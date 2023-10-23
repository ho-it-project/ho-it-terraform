data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.dev, {})
}

data "terraform_remote_state" "notification-server-ecr" {
  backend = "s3"
  config  = merge(var.remote_state.ecr.notification_server, {})
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = merge(var.remote_state.kms.dev, {})
}


data "terraform_remote_state" "iam" {
  backend = "s3"
  config  = merge(var.remote_state.iam.id, {})
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config  = merge(var.remote_state.lb.dev, {})
}
