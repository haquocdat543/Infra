resource "aws_ebs_volume" "example" {
  availability_zone = "ap-northeast-1a"
  size              = 40

  tags = {
    Name = "HelloWorld"
  }
}

