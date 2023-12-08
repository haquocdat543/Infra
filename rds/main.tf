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
    Name = "RDS"
    Env = "Dev"
  }
}
# Create Internet Gateway
resource "aws_internet_gateway" "prod_gw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "RDSInternetGateWay"
    Env = "Dev"
  }
}
# Create Custom Route Table
resource "aws_route_table" "RDSRouteTable" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_gw.id
  }

  tags = {
    Name = "RDS_RouteTable"
  }
}
# Create a Subnet
resource "aws_subnet" "RdsSubnet1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "RdsSubnet1"
    Env = "Dev"
  }
}
resource "aws_subnet" "RdsSubnet2" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "RdsSubnet2"
    Env = "Dev"
  }
}
# Create Associate Subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.RdsSubnet1.id
  route_table_id = aws_route_table.RDSRouteTable.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.RdsSubnet2.id
  route_table_id = aws_route_table.RDSRouteTable.id
}

resource "aws_db_subnet_group" "example" {
  name       = "main"

  subnet_ids = [ aws_subnet.RdsSubnet1.id, aws_subnet.RdsSubnet2.id ]

  tags = {
    Name = "RDS Subnet name"
  }
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "haquocdat"
  password             = "haquocdat"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.example.name
  skip_final_snapshot = true
  tags = {
    Name = "Rds"
    Env = "Dev"
  }
}
