terraform {
  backend "s3" {
    bucket         = "ho-it-me-apnortheast2-tfstate"
    key            = "hoit/terraform/iam/hoit-id/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
