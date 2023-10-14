data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.dev, {})
}


data "terraform_remote_state" "kms" {
  backend = "s3"

  config = merge(var.remote_state.kms.dev, {})
}


data "terraform_remote_state" "iam" {
  backend = "s3"
  config  = merge(var.remote_state.iam.id, {})
}

data "terraform_remote_state" "kafka" {
  backend = "s3"
  config  = merge(var.remote_state.ecr.kafka, {})
}

data "terraform_remote_state" "kafka-ui" {
  backend = "s3"
  config  = merge(var.remote_state.ecr.kafka-ui, {})
}


data "terraform_remote_state" "ho-it_me" {
  backend = "s3"
  config  = merge(var.remote_state.route53.ho-it_me, {})
}
