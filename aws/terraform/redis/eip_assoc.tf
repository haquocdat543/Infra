resource "aws_eip_association" "eip_assoc_to_Master" {
  instance_id   = aws_instance.Master.id
  allocation_id = aws_eip.Master.id
}


