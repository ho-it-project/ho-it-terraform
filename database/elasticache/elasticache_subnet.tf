resource "aws_elasticache_subnet_group" "default" {
  name        = "subnet-group-${data.terraform_remote_state.vpc.outputs.shard_id}"
  description = "subnet group for redis"
  subnet_ids  = data.terraform_remote_state.vpc.outputs.db_public_subnets
}
