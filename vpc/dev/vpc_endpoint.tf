# # Security Group for SSM VPC Endpoint
# resource "aws_security_group" "ssm_vpc_endpoint_sg" {
#   name   = "ssm-vpc-endpoint-${var.vpc_name}"
#   vpc_id = aws_vpc.default.id

#   ingress {
#     from_port = 443
#     to_port   = 443
#     protocol  = "TCP"
#     cidr_blocks = [
#       "10.0.0.0/8",
#     ]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ssm-${var.vpc_name}"
#   }
# }

# # SSM VPC Endpoint
# resource "aws_vpc_endpoint" "ssm_endpoint" {
#   vpc_id            = aws_vpc.default.id
#   service_name      = "com.amazonaws.${var.AWS_REGION}.ssm"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.ssm_vpc_endpoint_sg.id,
#   ]

#   private_dns_enabled = true
#   auto_accept         = true

#   tags = {
#     Name = "ssm-${var.shard_id}"
#   }
# }

# # Associate endpoint with subnets
# resource "aws_vpc_endpoint_subnet_association" "ssm_endpoint" {
#   count           = length(var.availability_zones)
#   vpc_endpoint_id = aws_vpc_endpoint.ssm_endpoint.id
#   subnet_id       = element(aws_subnet.private.*.id, count.index)
# }



# # Security Group for EC2 Messages VPC Endpoint
# resource "aws_security_group" "ec2_messages_vpc_endpoint_sg" {
#   name   = "ec2-messages-vpc-endpoint-${var.vpc_name}"
#   vpc_id = aws_vpc.default.id

#   ingress {
#     from_port = 443
#     to_port   = 443
#     protocol  = "TCP"
#     cidr_blocks = [
#       "10.0.0.0/8",
#     ]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ec2-messages-${var.vpc_name}"
#   }
# }

# # EC2 Messages VPC Endpoint
# resource "aws_vpc_endpoint" "ec2_messages_endpoint" {
#   vpc_id            = aws_vpc.default.id
#   service_name      = "com.amazonaws.${var.AWS_REGION}.ec2messages"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.ec2_messages_vpc_endpoint_sg.id,
#   ]

#   private_dns_enabled = true
#   auto_accept         = true

#   tags = {
#     Name = "ec2-messages-${var.shard_id}"
#   }
# }

# # Associate EC2 Messages endpoint with subnets
# resource "aws_vpc_endpoint_subnet_association" "ec2_messages_endpoint" {
#   count           = length(var.availability_zones)
#   vpc_endpoint_id = aws_vpc_endpoint.ec2_messages_endpoint.id
#   subnet_id       = element(aws_subnet.private.*.id, count.index)
# }

# # Security Group for SSM Messages VPC Endpoint
# resource "aws_security_group" "ssm_messages_vpc_endpoint_sg" {
#   name   = "ssm-messages-vpc-endpoint-${var.vpc_name}"
#   vpc_id = aws_vpc.default.id

#   ingress {
#     from_port = 443
#     to_port   = 443
#     protocol  = "TCP"
#     cidr_blocks = [
#       "10.0.0.0/8",
#     ]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ssm-messages-${var.vpc_name}"
#   }
# }




# # SSM Messages VPC Endpoint
# resource "aws_vpc_endpoint" "ssm_messages_endpoint" {
#   vpc_id            = aws_vpc.default.id
#   service_name      = "com.amazonaws.${var.AWS_REGION}.ssmmessages"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.ssm_messages_vpc_endpoint_sg.id,
#   ]

#   private_dns_enabled = true
#   auto_accept         = true

#   tags = {
#     Name = "ssm-messages-${var.shard_id}"
#   }
# }

# # Associate SSM Messages endpoint with subnets
# resource "aws_vpc_endpoint_subnet_association" "ssm_messages_endpoint" {
#   count           = length(var.availability_zones)
#   vpc_endpoint_id = aws_vpc_endpoint.ssm_messages_endpoint.id
#   subnet_id       = element(aws_subnet.private.*.id, count.index)
# }




# # Create a security group for ECR VPC Endpoint
# resource "aws_security_group" "ecr_vpc_endpoint_sg" {
#   name   = "ecr-vpc-endpoint-${var.vpc_name}"
#   vpc_id = aws_vpc.default.id

#   # Allow inbound traffic for ECR
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/8"] # Adjust this CIDR range accordingly
#   }

#   # Allow all outbound traffic
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ecr-${var.vpc_name}"
#   }
# }

# # Create a VPC Endpoint for ECR
# resource "aws_vpc_endpoint" "ecr_endpoint" {
#   vpc_id            = aws_vpc.default.id
#   service_name      = "com.amazonaws.${var.AWS_REGION}.ecr.dkr"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.ecr_vpc_endpoint_sg.id,
#   ]

#   private_dns_enabled = true

#   tags = {
#     Name = "ecr-${var.vpc_name}"
#   }
# }

# # Attach the ECR VPC Endpoint to the private subnets
# resource "aws_vpc_endpoint_subnet_association" "ecr_subnet_association" {
#   count           = length(var.availability_zones)
#   vpc_endpoint_id = aws_vpc_endpoint.ecr_endpoint.id
#   subnet_id       = element(aws_subnet.private.*.id, count.index)
# }


# # Security Group for ECS VPC Endpoint
# resource "aws_security_group" "ecs_vpc_endpoint_sg" {
#   name   = "ecs-vpc-endpoint-${var.vpc_name}"
#   vpc_id = aws_vpc.default.id

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/8"] # Adjust this CIDR range accordingly
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ecs-${var.vpc_name}"
#   }
# }

# # Create a VPC Endpoint for ECS
# resource "aws_vpc_endpoint" "ecs_endpoint" {
#   vpc_id            = aws_vpc.default.id
#   service_name      = "com.amazonaws.${var.AWS_REGION}.ecs"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.ecs_vpc_endpoint_sg.id,
#   ]

#   private_dns_enabled = true

#   tags = {
#     Name = "ecs-${var.vpc_name}"
#   }
# }

# # Attach the ECS VPC Endpoint to the private subnets
# resource "aws_vpc_endpoint_subnet_association" "ecs_subnet_association" {
#   count           = length(var.availability_zones)
#   vpc_endpoint_id = aws_vpc_endpoint.ecs_endpoint.id
#   subnet_id       = element(aws_subnet.private.*.id, count.index)
# }

# # Security Group for ECS Agent VPC Endpoint
# # resource "aws_security_group" "ecs_agent_vpc_endpoint_sg" {
# #   name   = "ecs-agent-vpc-endpoint-${var.vpc_name}"
# #   vpc_id = aws_vpc.default.id

# #   ingress {
# #     from_port   = 443
# #     to_port     = 443
# #     protocol    = "tcp"
# #     cidr_blocks = ["10.0.0.0/8"] # Adjust this CIDR range accordingly
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   tags = {
# #     Name = "ecs-agent-${var.vpc_name}"
# #   }
# # }

# # Create a VPC Endpoint for ECS Agent
# # resource "aws_vpc_endpoint" "ecs_agent_endpoint" {
# #   vpc_id            = aws_vpc.default.id
# #   service_name      = "com.amazonaws.${var.AWS_REGION}.ecs-agent"
# #   vpc_endpoint_type = "Interface"

# #   security_group_ids = [
# #     aws_security_group.ecs_agent_vpc_endpoint_sg.id,
# #   ]

# #   private_dns_enabled = true

# #   tags = {
# #     Name = "ecs-agent-${var.vpc_name}"
# #   }
# # }

# # Attach the ECS Agent VPC Endpoint to the private subnets
# # resource "aws_vpc_endpoint_subnet_association" "ecs_agent_subnet_association" {
# #   count           = length(var.availability_zones)
# #   vpc_endpoint_id = aws_vpc_endpoint.ecs_agent_endpoint.id
# #   subnet_id       = element(aws_subnet.private.*.id, count.index)
# # }
