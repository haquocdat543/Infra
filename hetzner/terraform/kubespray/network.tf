resource "hcloud_network" "mynet" {
  name     = "my-net"
  ip_range = "10.0.0.0/8"
}
