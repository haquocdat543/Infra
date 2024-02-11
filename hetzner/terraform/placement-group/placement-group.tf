resource "hcloud_placement_group" "my-placement-group" {
  name = "my-placement-group"
  type = "spread"
  labels = {
    key = "value"
  }
}
