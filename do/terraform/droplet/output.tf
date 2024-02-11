output "ip-address" {
  description = "Droplet ip address"
  value       = digitalocean_droplet.web.ipv4_address
}

