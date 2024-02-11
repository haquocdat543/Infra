# Create a new server running debian
resource "hcloud_server" "node1" {
  name        = "node1"
  image       = "debian-11"
  server_type = "cx11"
  firewall_ids = [hcloud_firewall.myfirewall.id]
  public_net {
    ipv4_enabled = true
  }
}
