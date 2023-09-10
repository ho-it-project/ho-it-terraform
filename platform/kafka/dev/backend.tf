terraform {
  backend "s3" {
    bucket         = "hoit-apnortheast2-tfstate"
    key            = "hoit/terraform/platform/kafka/dev/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
