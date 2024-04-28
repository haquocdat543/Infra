# Create a new container registry
resource "digitalocean_container_registry" "foobar" {
  name                   = "haquocdat-container-registry"
  subscription_tier_slug = "starter"
}


