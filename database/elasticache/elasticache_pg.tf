# Elasticache Parameter Group for redis
resource "aws_elasticache_parameter_group" "hoit_redis_cluster" {
  name        = "hoit-cluster-${data.terraform_remote_state.vpc.outputs.shard_id}"
  description = "hoit Elasticache Redis Parameter Group"

  # Please use the right engine and version
  family = "redis7"

  # List of cluster parameters
  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }

}
