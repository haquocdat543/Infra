resource "hcloud_floating_ip" "master" {
  type      = "ipv4"
  home_location = "nbg1"
}
