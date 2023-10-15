resource "aws_elasticache_replication_group" "hoit_redis_cluster" {

  replication_group_id = "hoit-redis-cluster-${data.terraform_remote_state.vpc.outputs.shard_id}"
  description          = "hoit redis cluster"
  node_type            = "cache.t3.micro"

  port           = var.port
  engine         = "redis"
  engine_version = "7.0"

  subnet_group_name = aws_elasticache_subnet_group.default.name

  security_group_ids = [
    aws_security_group.hoit_redis.id
  ]

  parameter_group_name = aws_elasticache_parameter_group.hoit_redis_cluster.name

  automatic_failover_enabled = true

  tags = {
    Name = "hoit-redis-cluster"
  }
}

resource "aws_route53_record" "hoit_redis" {
  zone_id = data.terraform_remote_state.route53.outputs.ho-it_me_zone_id
  name    = "redis.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"
  type    = "CNAME"
  ttl     = "300"
  records = [
    aws_elasticache_replication_group.hoit_redis_cluster.configuration_endpoint_address,
  ]
}
