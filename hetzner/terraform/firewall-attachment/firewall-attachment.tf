resource "hcloud_firewall_attachment" "fw_ref" {
    firewall_id = hcloud_firewall.myfirewall.id
    server_ids  = [hcloud_server.node1.id]
}
