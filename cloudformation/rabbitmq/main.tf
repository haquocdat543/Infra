# Profile configuration
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.profile
}

# Create VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Production"
  }
}
# Create Internet Gateway
resource "aws_internet_gateway" "prod_gw" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    "Name" = "VpcIGW"
  }
}
# Create Custom Route Table
resource "aws_route_table" "ProdRouteTable" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_gw.id
  }
  tags = {
    Name = "Prod_RouteTable"
  }
}
# Create a Subnet
resource "aws_subnet" "ProdSubnet" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "ProdSubnet"
  }
}
# Create Associate Subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ProdSubnet.id
  route_table_id = aws_route_table.ProdRouteTable.id
}
# Create Security Group to allow port 22, 80, 443
resource "aws_security_group" "ProdSecurityGroup" {
  name        = "ProdSecurityGroup"
  description = "Allow SSH HTTP HTTPS"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "AllowAllTraffic"
  }
}
# Create a network interface with an ip in the subnet that was created step 4
resource "aws_network_interface" "Master" {
  subnet_id       = aws_subnet.ProdSubnet.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.ProdSecurityGroup.id]
}

# Assign an elastic IP to the network interface created in step 7
resource "aws_eip" "Master" {
  domain                    = "vpc"
}

# Associate EIP to EC2 instances ENI
resource "aws_eip_association" "eip_assoc_to_Master" {
  instance_id   = aws_instance.Master.id
  allocation_id = aws_eip.Master.id
}

# Create Ubuntu server and install/ enable apache2
resource "aws_instance" "Master" {
  ami               = var.ami_id
  instance_type     = "t3.small"
  availability_zone = "ap-northeast-1a"
  key_name          = var.key_pair
  user_data         = file("./scripts/rabbitmqOnDocker.sh")

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.Master.id
  }

  tags = {
    "Name" = "Master"
  }
}

#Output
output "Master" {
  value = "ssh -i ~/${var.key_pair}.pem ubuntu@${aws_eip.Master.public_ip}"
}

