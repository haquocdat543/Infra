resource "aws_network_interface" "Master" {
  subnet_id       = aws_subnet.RedisSubnet1.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.Redis_SG.id]
}


