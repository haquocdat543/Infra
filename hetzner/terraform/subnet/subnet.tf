resource "hcloud_network_subnet" "hqd-subnet" {
  network_id   = hcloud_network.hqd-network.id
  type         = "cloud"
  network_zone = "us-west"
  ip_range     = "10.0.1.0/24"
}
