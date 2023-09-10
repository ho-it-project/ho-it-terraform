terraform {

  backend "s3" {
    bucket         = "hoit-apnortheast2-tfstate"
    key            = "hoit/terraform/ecr/hoit/notification-server/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}


