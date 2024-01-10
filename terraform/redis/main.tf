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
    Name = "Redis"
    Env = "Dev"
  }
}
# Create Internet Gateway
resource "aws_internet_gateway" "prod_gw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "RedisInternetGateWay"
    Env = "Dev"
  }
}
# Create Custom Route Table
resource "aws_route_table" "RedisRouteTable" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_gw.id
  }

  tags = {
    Name = "Redis_RouteTable"
  }
}
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
# Create Associate Subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.RedisSubnet1.id
  route_table_id = aws_route_table.RedisRouteTable.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.RedisSubnet2.id
  route_table_id = aws_route_table.RedisRouteTable.id
}

resource "aws_db_subnet_group" "example" {
  name       = "main"

  subnet_ids = [ aws_subnet.RedisSubnet1.id, aws_subnet.RedisSubnet2.id ]

  tags = {
    Name = "Redis Subnet name"
  }
}

resource "aws_security_group" "Redis_SG" {
  name        = "Redis-SG"
  description = "Allow 6379"
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
    Name = "Redis-SG"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "tf-test-cache-subnet"
  subnet_ids = [ aws_subnet.RedisSubnet1.id, aws_subnet.RedisSubnet1.id ]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "haquocdat-redis"
  engine               = "redis"
  apply_immediately    = true
  availability_zone    = "ap-northeast-1a"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  security_group_ids   = [ aws_security_group.Redis_SG.id ]
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.id
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
}

resource "aws_network_interface" "Master" {
  subnet_id       = aws_subnet.RedisSubnet1.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.Redis_SG.id]
}

resource "aws_eip" "Master" {
  domain                    = "vpc"
}

resource "aws_eip_association" "eip_assoc_to_Master" {
  instance_id   = aws_instance.Master.id
  allocation_id = aws_eip.Master.id
}

resource "aws_instance" "Master" {
  ami               = var.ami_id
  instance_type     = "t3.small"
  availability_zone = "ap-northeast-1a"
  key_name          = var.key_pair

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
  value = "ssh -i ~/${var.key_pair}.pem ec2-user@${aws_eip.Master.public_ip}"
}

output "hostname" {
  value = aws_elasticache_cluster.redis.cache_nodes.0.address
}

output "port" {
  value = aws_elasticache_cluster.redis.cache_nodes.0.port
}

output "endpoint" {
  value = "${aws_elasticache_cluster.redis.cache_nodes[0].address}:${aws_elasticache_cluster.redis.cache_nodes[0].port}"
}
