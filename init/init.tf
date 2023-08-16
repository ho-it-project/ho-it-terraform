provider "aws" {
  region = var.AWS_REGION
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.ACCOUNT_ID}-apnortheast2-tfstate"

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

