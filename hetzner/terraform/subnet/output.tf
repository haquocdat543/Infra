output "network_id" {
  description = "Network id"
  value       = hcloud_network.hqd-network.id
}

output "subnet_id" {
  description = "Subnet id"
  value       = hcloud_network_subnet.hqd-subnet.id
}
