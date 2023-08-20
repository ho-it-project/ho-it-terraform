variable "aws_region" {
  default = "ap-northeast-2"
}

variable "tag_env" {
  description = ""
}

variable "tag_first_owner" {
  description = ""
}

variable "tag_second_owner" {
  description = ""
}

variable "tag_project" {
  description = ""
}

variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}
