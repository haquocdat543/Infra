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

# Create a new container registry
resource "digitalocean_container_registry" "foobar" {
  name                   = "haquocdat-container-registry"
  subscription_tier_slug = "starter"
}

output "contaiiner-registry-id" {
  description = "contaiiner-registry-id"
  value       = digitalocean_container_registry.foobar.id
}

output "contaiiner-registry-name" {
  description = "contaiiner-registry-name"
  value       = digitalocean_container_registry.foobar.name
}

output "contaiiner-registry-endpoint" {
  description = "contaiiner-registry-endpoint"
  value       = digitalocean_container_registry.foobar.endpoint
}
