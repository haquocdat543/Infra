resource "hcloud_volume" "master" {
  name     = "hqd-volume"
  location = "nbg1"
  size     = 10
}
