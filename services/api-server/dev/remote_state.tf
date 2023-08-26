data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.dev, {})
}

data "terraform_remote_state" "api-server-ecr" {
  backend = "s3"
  config  = merge(var.remote_state.ecr.api_server, {})
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = merge(var.remote_state.kms.dev, {})
}


data "terraform_remote_state" "iam" {
  backend = "s3"
  config  = merge(var.remote_state.iam.id, {})
}
