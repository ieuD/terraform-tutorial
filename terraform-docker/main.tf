terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>2.15.0" // ~> 2.xx 
    }
  }
}

provider "docker" {

}

resource "random_string" "random" {
  count = 2 // 
  length = 4
  special = false
  upper = false
}


resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}


resource "docker_container" "nodered_container" {
  count = 2
  name  = join("-", ["nodered",random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}




output "ip_address" {
  # for_each = docker_container.nodered_container[*]
  value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address, i.ports[0]["external"]])]
  description = "The IP address and external port of  the container"
}

output "container-name" {
  value = docker_container.nodered_container[*].name
}

