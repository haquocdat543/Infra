# Create a Subnet
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public1"
  }
}
resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public2"
  }
}

