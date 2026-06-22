terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "web_page" {
  name = "my-first-web-page:latest"
}

resource "docker_container" "nginx_server" {
  image = docker_image.web_page.image_id
  name  = "terraform-managed-nginx"
  
  ports {
    internal = 80
    external = 8081
  }
}