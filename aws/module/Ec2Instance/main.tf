locals {
  zone = var.zone 
  ami_id = var.ami_id 
  instance_type = var.instance_type 
  key_pair  = var.key_pair  
  amount  = var.amount
}

module "hqd_master_instances" {
  source  = "./Instance"
  prefix  = "Test"
  zone = local.zone 
  ami_id = local.ami_id 
  instance_type = local.instance_type 
  key_pair  = local.key_pair  
  amount  = local.amount
}
