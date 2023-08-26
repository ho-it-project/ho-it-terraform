provider "aws" {
  region = var.AWS_REGION
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.ACCOUNT_ALIAS}-apnortheast2-tfstate"


}

resource "aws_s3_bucket_versioning" "terraform_state_version" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
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


