resource "aws_security_group" "rds_postgresql_sg" {
  name        = "rds-postgresql-${data.terraform_remote_state.vpc.outputs.shard_id}-sg"
  description = "RDS PostgreSQL Security Group for DEV"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
