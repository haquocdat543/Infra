# Profile configuration
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.profile
}

# Create VPC
resource "aws_vpc" "prod-vpc" {
  enable_dns_support = true
  enable_dns_hostnames = true
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
resource "aws_rds_cluster" "example" {
  cluster_identifier = "example"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "15.5"
  database_name      = "Aurora"
  master_username    = "haquocdat"
  master_password    = "haquocdat"
  skip_final_snapshot = true

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "example" {
  cluster_identifier = aws_rds_cluster.example.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.example.engine
  engine_version     = aws_rds_cluster.example.engine_version
  db_subnet_group_name = aws_db_subnet_group.example.name
  tags = {
    Name = "Rds"
    Env = "Dev"
  }
}

#Output

output "db_instance_port" {
  description = "The database port"
  value       = aws_rds_cluster_instance.example.port
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = aws_rds_cluster_instance.example.availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_rds_cluster_instance.example.endpoint
}

output "db_listener_endpoint" {
  description = "Specifies the listener connection endpoint for SQL Server Always On"
  value       = aws_rds_cluster_instance.example.endpoint
}

output "db_instance_engine" {
  description = "The database engine"
  value       = aws_rds_cluster_instance.example.engine
}

output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_rds_cluster_instance.example.identifier
}

