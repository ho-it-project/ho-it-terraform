# Region
output "aws_region" {
  description = "Region of VPC"
  value       = var.AWS_REGION
}

output "region_namespace" {
  description = "Region name without '-'"
  value       = replace(var.AWS_REGION, "-", "")
}

# Availability_zones
output "availability_zones" {
  description = "Availability zone list of VPC"
  value       = var.availability_zones
}

# Shard
output "shard_id" {
  description = "The shard ID which will be used to distinguish the env of resources"
  value       = var.shard_id
}

# VPC
output "vpc_name" {
  description = "VPC name"
  value       = var.vpc_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.default.id
}

output "cidr_block" {
  description = "CIDR block of VPC"
  value       = aws_vpc.default.cidr_block
}


output "cidr_numeral" {
  description = "number that specifies the vpc range (B class)"
  value       = var.cidr_numeral
}


# Prviate subnets
output "private_subnets" {
  description = "List of private subnet ID in VPC"
  value       = aws_subnet.private.*.id
}


# Public subnets
output "public_subnets" {
  description = "List of public subnet ID in VPC"
  value       = aws_subnet.public.*.id
}



# Private Database Subnets
output "db_private_subnets" {
  description = "List of DB private subnet ID in VPC"
  value       = aws_subnet.private_db.*.id
}

output "db_public_subnets" {
  description = "List of DB public subnet ID in VPC"
  value       = aws_subnet.public_db.*.id

}


# Route53
output "route53_internal_zone_id" {
  description = "Internal Zone ID for VPC"
  value       = aws_route53_zone.internal.zone_id
}

output "route53_internal_domain" {
  description = "Internal Domain Name for VPC"
  value       = aws_route53_zone.internal.name
}

# Security Group
output "aws_security_group_bastion_id" {
  description = "ID of bastion security group"
  value       = aws_security_group.bastion.id
}

output "aws_security_group_bastion_aware_id" {
  description = "ID of bastion aware security group"
  value       = aws_security_group.bastion_aware.id
}

output "aws_security_group_default_id" {
  description = "ID of default security group"
  value       = aws_security_group.default.id
}

output "aws_security_group_home_id" {
  description = "ID of home security group"
  value       = aws_security_group.home.id
}

# ETC
output "env_suffix" {
  description = "Suffix of the environment"
  value       = var.env_suffix
}

output "billing_tag" {
  description = "The environment value for biliing consolidation."
  value       = var.billing_tag
}


# output "vpc_endpoint_ssm_id" {
#   description = "ID of SSM VPC Endpoint"
#   value       = aws_vpc_endpoint.ssm_endpoint.id
# }
# output "ssm_vpc_endpoint_sg" {
#   description = "ID of SSM VPC Endpoint Security Group"
#   value       = aws_security_group.ssm_vpc_endpoint_sg.id
# }
# resource "null_resource" "output_to_file" {
#   provisioner "local-exec" {
#     command = <<-EOT
#       echo vpc_output > output.txt
#       echo "aws_region = ${var.AWS_REGION}" >> output.txt
#       echo "region_namespace = ${replace(var.AWS_REGION, "-", "")}" >> output.txt
#       echo "availability_zones = ${join(",", var.availability_zones)}" >> output.txt
#       echo "vpc_name = ${var.vpc_name}" >> output.txt
#       echo "vpc_id = ${aws_vpc.default.id}" >> output.txt
#       echo "cidr_block = ${aws_vpc.default.cidr_block}" >> output.txt
#       echo "cidr_numeral = ${var.cidr_numeral}" >> output.txt
#       echo "private_subnets = ${join(",", aws_subnet.private.*.id)}" >> output.txt
#       echo "public_subnets = ${join(",", aws_subnet.public.*.id)}" >> output.txt
#       echo "db_private_subnets = ${join(",", aws_subnet.private_db.*.id)}" >> output.txt
#       echo "route53_internal_zone_id = ${aws_route53_zone.internal.zone_id}" >> output.txt
#       echo "route53_internal_domain = ${aws_route53_zone.internal.name}" >> output.txt
#       echo "route53_internal_domain_name_servers = ${aws_route53_zone.internal.name_servers}" >> output.txt
#       echo "aws_security_group_bastion_id = ${aws_security_group.bastion.id}" >> output.txt
#       echo "aws_security_group_bastion_aware_id = ${aws_security_group.bastion_aware.id}" >> output.txt
#       echo "aws_security_group_default_id = ${aws_security_group.default.id}" >> output.txt
#       echo "aws_security_group_home_id = ${aws_security_group.home.id}" >> output.txt
#       echo "env_suffix = ${var.env_suffix}" >> output.txt
#       echo "billing_tag = ${var.billing_tag}" >> output.txt
#     EOT
#   }
# }
resource "null_resource" "output_to_file" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "aws_region = ${var.AWS_REGION}" > output.txt
      echo "region_namespace = ${replace(var.AWS_REGION, "-", "")}" >> output.txt
      echo "availability_zones = ${join(",", var.availability_zones)}" >> output.txt
      echo "vpc_name = ${var.vpc_name}" >> output.txt
      echo "vpc_id = ${aws_vpc.default.id}" >> output.txt
      echo "cidr_block = ${aws_vpc.default.cidr_block}" >> output.txt
      echo "cidr_numeral = ${var.cidr_numeral}" >> output.txt
      echo "private_subnets = ${join(",", aws_subnet.private.*.id)}" >> output.txt
      echo "public_subnets = ${join(",", aws_subnet.public.*.id)}" >> output.txt
      echo "db_private_subnets = ${join(",", aws_subnet.private_db.*.id)}" >> output.txt
      echo "route53_internal_zone_id = ${aws_route53_zone.internal.zone_id}" >> output.txt
      echo "route53_internal_domain = ${aws_route53_zone.internal.name}" >> output.txt
      echo "aws_security_group_bastion_id = ${aws_security_group.bastion.id}" >> output.txt
      echo "aws_security_group_bastion_aware_id = ${aws_security_group.bastion_aware.id}" >> output.txt
      echo "aws_security_group_default_id = ${aws_security_group.default.id}" >> output.txt
      echo "aws_security_group_home_id = ${aws_security_group.home.id}" >> output.txt
      echo "env_suffix = ${var.env_suffix}" >> output.txt
      echo "billing_tag = ${var.billing_tag}" >> output.txt
    EOT
  }
}
