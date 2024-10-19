resource "docker_container" "nginx" {
  image   = docker_image.nginx.image_id
  name    = "tutorial"
  restart = "always"
  ports {
    internal = 80
    external = 8000
  }
}

