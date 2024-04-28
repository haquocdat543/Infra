resource "aws_instance" "Master" {
  ami               = var.ami_id
  instance_type     = "t3.small"
  availability_zone = "ap-northeast-1a"
  key_name          = var.key_pair

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.Master.id
  }

  tags = {
    "Name" = "Master"
  }
}


