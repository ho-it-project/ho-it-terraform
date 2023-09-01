resource "aws_db_instance" "rds_postgresql" {
  parameter_group_name = aws_db_parameter_group.rds_postgresql_pg.name
  vpc_security_group_ids = [
    aws_security_group.rds_postgresql_sg.id,
  ]
  engine                = "postgres"
  engine_version        = "15.4"
  instance_class        = "db.t3.micro"
  max_allocated_storage = 20
  allocated_storage     = 20
  storage_type          = "gp2"
  username              = "hoit"
  password              = var.rds_password
  # manage_master_user_password = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group_dev.name
  publicly_accessible  = true
  skip_final_snapshot  = true

  #   final_snapshot_identifier = "my-final-snapshot"
  backup_retention_period = 7
  tags = {
    Name = "rds-postgresql-${data.terraform_remote_state.vpc.outputs.shard_id}"
  }
}


output "rds_postgresql_endpoint" {
  value = aws_db_instance.rds_postgresql.endpoint
}


output "rds_postgresql_address" {
  value = aws_db_instance.rds_postgresql.address
}
