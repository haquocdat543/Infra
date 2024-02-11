resource "hcloud_network_route" "privNet" {
  network_id  = hcloud_network.hqd-network.id
  destination = "10.100.1.0/24"
  gateway     = "10.0.1.1"
}
