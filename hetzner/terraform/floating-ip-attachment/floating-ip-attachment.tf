resource "hcloud_floating_ip_assignment" "main" {
  floating_ip_id = hcloud_floating_ip.master.id
  server_id      = hcloud_server.node1.id
}
