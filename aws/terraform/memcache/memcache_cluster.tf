resource "aws_elasticache_cluster" "example" {
  cluster_id           = "haquocdat-memcache"
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
}

