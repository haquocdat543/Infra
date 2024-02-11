resource "hcloud_volume_attachment" "main" {
  volume_id = hcloud_volume.master.id
  server_id = hcloud_server.node1.id
  automount = true
}
