locals {
  prefix         = var.prefix
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  zone           = var.zone
  key_pair       = var.key_pair
  amount          = var.amount
}

resource "aws_instance" "this" {
  ami               = local.ami_id
  instance_type     = local.instance_type
  availability_zone = local.zone
  key_name          = local.key_pair
  count             = local.amount
  tags = {
    "Name" = "${local.prefix}-${count.index + 1}"
  }
}
