variable "AWS_REGION" {
  default = "ap-northeast-2"
}


variable "assume_role_arn" {
  description = "The ARN of the role to assume"
  default     = ""
}