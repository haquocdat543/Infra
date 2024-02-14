resource "hcloud_server_network" "srvnetwork" {
  server_id  = hcloud_server.node1.id
  network_id = hcloud_network.mynet.id
  ip         = "10.0.1.5"
}
