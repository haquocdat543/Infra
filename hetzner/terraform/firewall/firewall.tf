resource "hcloud_firewall" "myfirewall" {
  name = "hqd-firewall"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80-85"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

}
