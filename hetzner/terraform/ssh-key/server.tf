# Create a new server running debian
resource "hcloud_server" "node1" {
  name        = "node1"
  image       = "debian-11"
  server_type = "cx11"
  ssh_keys = [ hcloud_ssh_key.default.name ]
  public_net {
    ipv4_enabled = true
  }
}
