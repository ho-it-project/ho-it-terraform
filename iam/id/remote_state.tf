data "terraform_remote_state" "kms_apne2" {
  backend = "s3"
  config = {
    bucket   = var.remote_state_bucket
    region   = var.remote_state_region
    key      = var.remote_state_key
    role_arn = var.assume_role_arn
  }
}
