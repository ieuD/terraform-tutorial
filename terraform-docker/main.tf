terraform {
  required_providers{
    docker = {
      source = "kreuzwerker/docker"
      version = "~>2.15.0" // ~> 2.xx 
    }
  }
}

provider "docker" {
  
}

resource "docker_image" "nodered_image"{
  name = "nodered/node-red:latest"
}

