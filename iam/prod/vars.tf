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
