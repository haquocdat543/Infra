resource "hcloud_network" "hqd-network" {
  name     = "hqd-network"
  ip_range = "10.0.0.0/8"
}
