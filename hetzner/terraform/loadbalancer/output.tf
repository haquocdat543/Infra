output "ip_address" {
  description = "Server ip address"
  value       = hcloud_server.node1.ipv4_address
}
