# Create a Subnet
resource "aws_subnet" "RedisSubnet1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "RedisSubnet1"
    Env = "Dev"
  }
}
resource "aws_subnet" "RedisSubnet2" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "RedisSubnet2"
    Env = "Dev"
  }
}

