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

