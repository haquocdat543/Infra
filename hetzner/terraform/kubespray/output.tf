output "master_ip_address" {
  description = "master  ip address"
  value       = hcloud_server.master.ipv4_address
}

output "master1_ip_address" {
  description = "master1 ip address"
  value       = hcloud_server.master1.ipv4_address
}

output "worker1_ip_address" {
  description = "worker1 ip address"
  value       = hcloud_server.worker1.ipv4_address
}

output "worker2_ip_address" {
  description = "worker2 ip address"
  value       = hcloud_server.worker2.ipv4_address
}

