resource "hcloud_load_balancer" "load_balancer" {
  name               = "my-load-balancer"
  load_balancer_type = "lb11"
  location           = "hil"
  target {
    type      = "server"
    server_id = hcloud_server.node1.id
  }
}
