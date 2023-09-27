variable "MYAPP_SERVICE_ENABLE" {
  default = 1
}

variable "ACCOUNT_ID" {
  default = ""
}


variable "AWS_ECS_AMI" {
  default = "ami-016e409dfaa836cb4"
}

variable "SERVICE_PORT" {

}

variable "SECANDARY_SERVICE_PORT" {
  default = 0

}
