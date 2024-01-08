# Profile configuration
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.profile
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "haquocdat-redis"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
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
