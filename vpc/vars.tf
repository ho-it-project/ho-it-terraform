variable "AWS_REGION" {
  type    = string
  default = "ap-northeast-2"
}

variable "ACCOUNT_ALIAS" {
  default = "hoit" # AWS Account ID Alias
}
variable "shard_id" {
  default = ""
}

# variable "ACCOUNT_ID" {
#   description = "AWS Account Number ID 12 digit"
# }

variable "vpc_name" {
  description = "VPC Name"
}

variable "cidr_numeral" {
  description = "The VPC CIDR numeral (10.x.0.0/16)"
}

variable "cidr_numeral_public" {
  default = {
    "0" = "0"
    "1" = "16"
    "2" = "32"
  }
}


variable "cidr_numeral_private" {
  default = {
    "0" = "80"
    "1" = "96"
    "2" = "112"
  }
}

variable "cidr_numeral_private_db" {
  default = {
    "0" = "160"
    "1" = "176"
    "2" = "192"
  }
}
variable "cidr_numeral_public_db" {
  default = {
    "0" = "208"
    "1" = "224"
    "2" = "240"
  }
}


variable "billing_tag" {
  description = "The AWS tag used to track AWS charges."
}

variable "availability_zones" {
  type        = list(string)
  description = "A comma-delimited list of availability zones for the VPC."
}


variable "availability_zones_without_b" {
  type        = list(string)
  description = "A comma-delimited list of availability zones except for ap-northeast-2b"
}

variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}

variable "atlantis_user" {
  description = "The username that will be triggering atlantis commands. This will be used to name the session when assuming a role. More information - https://github.com/runatlantis/atlantis#assume-role-session-names"
  default     = "atlantis_user"
}

variable "subnet_no_private" {
  description = "This value means the number of private subnets"
  default     = "3"
}

variable "env_suffix" {
  description = "env suffix"
  default     = ""
}

# peering ID with artp VPC
# variable "vpc_peer_connection_id_artp_apne2" {}
# variable "artp_destination_cidr_block" {}
