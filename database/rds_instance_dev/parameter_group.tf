resource "aws_db_parameter_group" "rds_postgresql_pg" {
  name   = "rds-postgresql-${data.terraform_remote_state.vpc.outputs.shard_id}-pg"
  family = "postgres15"

  parameter {
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "pg_stat_statements.track"
    value = "all"
  }
  parameter {
    name         = "pg_stat_statements.max"
    value        = "10000"
    apply_method = "pending-reboot"

  }
  parameter {
    name  = "pg_stat_statements.track_utility"
    value = "on"
  }
  parameter {
    name         = "autovacuum"
    value        = "on"
    apply_method = "pending-reboot"
  }
  parameter {
    name         = "timezone"
    value        = "Asia/Seoul"
    apply_method = "pending-reboot"
  }
}


