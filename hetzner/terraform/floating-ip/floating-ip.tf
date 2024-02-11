resource "hcloud_floating_ip" "master" {
  type      = "ipv4"
  server_id = hcloud_server.node1.id
}
