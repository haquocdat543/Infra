resource "hcloud_rdns" "master" {
  server_id  = hcloud_server.node1.id
  ip_address = hcloud_server.node1.ipv4_address
  dns_ptr    = "example.com"
}
