resource "hcloud_snapshot" "my-snapshot" {
  server_id = hcloud_server.node1.id
}
