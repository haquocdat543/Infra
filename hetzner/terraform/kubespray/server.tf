# Create a new server running debian
resource "hcloud_server" "master" {
  name        = "master"
  image       = "centos-stream-9"
  server_type = "cx11"
  ssh_keys = [ hcloud_ssh_key.default.name ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = hcloud_network.mynet.id
    ip         = "10.0.1.101"
  }
  depends_on = [
    hcloud_network_subnet.foonet
  ]
}

resource "hcloud_server" "master1" {
  name        = "master1"
  image       = "centos-stream-9"
  server_type = "cx11"
  ssh_keys = [ hcloud_ssh_key.default.name ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = hcloud_network.mynet.id
    ip         = "10.0.1.102"
  }
  depends_on = [
    hcloud_network_subnet.foonet
  ]
}

resource "hcloud_server" "worker1" {
  name        = "worker1"
  image       = "centos-stream-9"
  server_type = "cx11"
  ssh_keys = [ hcloud_ssh_key.default.name ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = hcloud_network.mynet.id
    ip         = "10.0.1.103"
  }
  depends_on = [
    hcloud_network_subnet.foonet
  ]
}

resource "hcloud_server" "worker2" {
  name        = "worker2"
  image       = "centos-stream-9"
  server_type = "cx11"
  ssh_keys = [ hcloud_ssh_key.default.name ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = hcloud_network.mynet.id
    ip         = "10.0.1.104"
  }
  depends_on = [
    hcloud_network_subnet.foonet
  ]
}

