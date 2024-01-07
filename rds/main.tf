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

resource "aws_security_group" "Rds_SG" {
  name        = "Rds-SG"
  description = "Allow 3306"
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
    Name = "Rds-SG-3306"
  }
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.6"
  instance_class       = "db.t2.micro"
  username             = "haquocdat"
  password             = "haquocdat"
  port                 = 3306
  parameter_group_name = "default.mariadb10.6"
  db_subnet_group_name = aws_db_subnet_group.example.name
  vpc_security_group_ids = [ aws_security_group.Rds_SG.id ]
  skip_final_snapshot = true
  tags = {
    Name = "Rds"
    Env = "Dev"
  }
}

#Output

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.example.port
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = aws_db_instance.example.availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.example.endpoint
}

output "db_listener_endpoint" {
  description = "Specifies the listener connection endpoint for SQL Server Always On"
  value       = aws_db_instance.example.endpoint
}

output "db_instance_engine" {
  description = "The database engine"
  value       = aws_db_instance.example.engine
}

output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.example.identifier
}
