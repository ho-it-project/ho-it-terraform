# AWS kms Key
resource "aws_kms_key" "deployment_common" {
  description         = "KMS key for common secrets in ${var.AWS_REGION}."
  enable_key_rotation = true
}


#Alias for the key
resource "aws_kms_alias" "deployment_common" {
  name          = "alias/deployment-common"
  target_key_id = aws_kms_key.deployment_common.key_id
}
