variable "AWS_REGION" {
  type    = string
  default = "ap-northeast-2"
}

variable "ACCOUNT_ALIAS" {
  default = "hoit" # AWS Account ID Alias
}

variable "ACCOUNT_ID" {
  description = "AWS Account Number ID 12 digit"
}


variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}


variable "remote_state_region" {
  default = "ap-northeast-2"
}

variable "remote_state_bucket" {
  default = "hoit-apnortheast2-tfstate"
}

variable "remote_state_key" {
  default = "hoit/terraform/kms/hoit-id/terraform.tfstate"
}
 
