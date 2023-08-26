data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.dev, {})
}

data "terraform_remote_state" "ems-front" {
  backend = "s3"
  config  = merge(var.remote_state.ecr.ems_front, {})
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = merge(var.remote_state.kms.dev, {})
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config  = merge(var.remote_state.iam.id, {})
}
