resource "cloudflare_record" "example" {
  zone_id = var.zone_id
  name    = "example"
  value   = "192.0.2.1"
  type    = "A"
  ttl     = 3600
  proxied = true
}
