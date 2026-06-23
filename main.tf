terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Instruct Terraform to build the image from the local Dockerfile
resource "docker_image" "web_page" {
  name = "my-first-web-page:latest"
  build {
    context = "."
  }
}

resource "docker_container" "nginx_server" {
  # Use the unique ID of the newly built image
  image = docker_image.web_page.image_id
  name  = "terraform-managed-nginx"
  
  ports {
    internal = 80
    external = 8081
  }
