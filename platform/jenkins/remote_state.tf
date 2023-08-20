data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = merge(var.remote_state.vpc.dev, {})
}

# data "terraform_remote_state" "kms" {
#   backend = "s3"

#   config = merge(var.remote_state.kms.id.dev, {})
# }
