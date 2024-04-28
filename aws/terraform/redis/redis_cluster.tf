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


