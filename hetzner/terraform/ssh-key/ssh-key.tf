# Create a new SSH key
resource "hcloud_ssh_key" "default" {
  name       = "Terraform Hetzner"
  public_key = file("./key/id_rsa.pub")
}
