resource "aws_db_subnet_group" "example" {
  name       = "main"

  subnet_ids = [ aws_subnet.RedisSubnet1.id, aws_subnet.RedisSubnet2.id ]

  tags = {
    Name = "Redis Subnet name"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "tf-test-cache-subnet"
  subnet_ids = [ aws_subnet.RedisSubnet1.id, aws_subnet.RedisSubnet1.id ]
}
