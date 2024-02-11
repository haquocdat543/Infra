# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  image  = "centos-stream-9-x64"
  name   = "haquocdat"
  region = "sfo"
  size   = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}


