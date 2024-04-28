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

