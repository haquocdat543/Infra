# Profile configuration
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.profile
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-northeast-1a"
  size              = 40

  tags = {
    Name = "HelloWorld"
  }
}
