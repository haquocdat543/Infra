# Create a new server running debian
resource "hcloud_server" "node1" {
  name        = "node1"
  image       = "debian-11"
  server_type = "cx11"
  placement_group_id = hcloud_placement_group.my-placement-group.id
  public_net {
    ipv4_enabled = true
  }
}
