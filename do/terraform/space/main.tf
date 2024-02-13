terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_spaces_bucket" "foobar" {
  name   = "haquocdat-space-bucket"
  region = "sfo2"
}
