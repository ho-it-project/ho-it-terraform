provider "aws" {
  region = var.AWS_REGION
  assume_role {
    role_arn = var.assume_role_arn
  }
}
