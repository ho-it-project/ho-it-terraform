resource "aws_db_subnet_group" "rds_subnet_group_dev" {
  name        = "dbsubnets-${data.terraform_remote_state.vpc.outputs.vpc_name}-dev"
  description = "Subnets available for the RDS DB Instance for DEV"
  subnet_ids  = data.terraform_remote_state.vpc.outputs.db_public_subnets
  tags = {
    Name = "dbsubnets-${data.terraform_remote_state.vpc.outputs.vpc_name}-dev"
  }
}
