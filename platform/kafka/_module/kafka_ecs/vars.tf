
variable "service_name" {

}

variable "broker_count" {
  default = 1
}

variable "domain_name" {
  default = "kafka"
}
variable "domain" {
  default = ""
}

variable "AWS_ECS_AMI" {
  default = "ami-016e409dfaa836cb4"
}

variable "instance_type" {
  default = "t2.small"
}

variable "vpc_endpoint_ssm_id" {
}
variable "ssm_vpc_endpoint_sg" {

}

variable "account_id" {
  description = "The AWS account number"
}

variable "repository_url" {

}

variable "shard_id" {
  description = "Text used to identify shard of infrastructure components. For new shards, this should be only the shard id and should not include the AWS region (e.g. ap01)"
}

variable "private_subnets" {
  description = "A comma-delimited list of private subnets for the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "A comma-delimited list of public subnets for the VPC"
  type        = list(string)
  default     = []
}

variable "aws_region" {
  description = "The AWS region to deploy the shard storage layer into"
}

variable "billing_tag" {
  description = "The shard's default billing tag"
}

variable "target_vpc" {
  description = "The AWS ID of the VPC this shard is being deployed into"
}

variable "vpc_name" {
  description = "The unique VPC name this storage layer belongs to"
}

variable "availability_zone" {
  description = ""
  default     = "ap-northeast-2a"
}

variable "route53_internal_domain" {
  description = "base domain name for internal"
}

variable "route53_internal_zone_id" {
  description = "internal domain zone id"
}

variable "route53_external_zone_id" {
  description = "r53 zone id"
  default     = ""
}

variable "vpc_cidr_numeral" {
  description = "The VPC CIDR numeral (e.g. 'n' in 10.n.0.0/16)"
}

variable "acm_external_ssl_certificate_arn" {
  description = "ssl cert id"
  default     = ""
}

variable "ext_lb_ingress_cidrs" {
  description = " Ingress of security group of external load-balancer"
  type        = list(string)
}

variable "home_sg" {
  description = "Office people IP list."
  default     = ""
}


variable "aws_iam_instance_profile_ecs_ec2_role_id" {
  description = "The IAM Instance Profile ID for ECS EC2"
}

variable "newrelic_monitor" {
  description = "Boolean of whether or not to monitor with newrelic"
  default     = false
}

variable "ssh_key_name" {
  description = "The key name to SSH into instances with"
  default     = "preprod-master"
}
variable "deployment_common_arn" {
  description = "The ARN of KMS for deployment_common."
}
variable "ecs_service_role_arn" {

}

variable "instance_size" {
  description = "instance type"
  default     = "t3a.small"
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


variable "instance_count_desired" {
  description = "The desired number of agents that are to be active"
  default     = 1
}

variable "instance_count_max" {
  description = "The maximum number of agents that are to be active"
  default     = 1
}

variable "instance_count_min" {
  description = "The minimum number of agents that are to be active"
  default     = 1
}

