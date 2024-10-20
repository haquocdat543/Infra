terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "vba-terraform-state-locks"
    region         = "ap-southeast-1"
    key            = "applications/prod/internal/eventbridge/ec2-scheduler/terraform.tfstate"
    dynamodb_table = "vba-terraform-state-locks"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      Region      = "ap-southeast-1"
      Terraform   = "true"
      Environment = basename(dirname("${path.cwd}/../../../"))
      Project     = basename(dirname("${path.cwd}/../../"))
      Component   = basename(dirname("${path.cwd}/../"))
    }
  }
}

