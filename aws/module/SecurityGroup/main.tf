terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}

provider "aws" {
  region = local.region
}

data "aws_vpc" "default" {
  default = true
}

locals {
  region         = var.region
  vpc_id         = var.vpc_id == "" ? data.aws_vpc.default.id : var.vpc_id
  prefix         = var.prefix
}

module "sg_public_ssh_http_https" {
  source  = "./SG"
  sg_name = "${local.prefix}_sg_public_ssh_http_https"
  vpc_id = ""
  public_ports = ["22", "80", "443"]
}

module "sg_nodeport_k8snodes" {
  source  = "./SG"
  sg_name = "${local.prefix}_sg_nodeport-k8snodes"
  vpc_id = ""
  rules = [{
    from_port   = "30000"
    to_port     = "32767"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow NodePort from public"
  }]
}

#default cidr_blocks is set by default VPC's cidr_blocks
module "sg_kubernetes_cores" {
  source  = "./SG"
  sg_name = "${local.prefix}_sg_kubernetes-cores"
  vpc_id = ""
  rules = [{
    port        = "6443"
    }, {
    from_port   = "2379"
    to_port     = "2380"
    }, {
    from_port   = "10250"
    to_port     = "10259"
    }, {
    from_port   = "30000"
    to_port     = "32767"
    }, {
    from_port   = "6783"
    to_port     = "6783"
    }, {
    from_port   = "6783"
    to_port     = "6784"
    protocol    = "udp"    
  }, ]
}

#This rule fix issue of pod calico-node is not ready (0/1)
module "sg_k8s_inside" {
  source  = "./SG"
  sg_name = "${local.prefix}_sg_k8s_inside"
  vpc_id = ""
  rules = [{
    from_port   = "0"
    to_port     = "63000"
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/16"]
  }]
}
