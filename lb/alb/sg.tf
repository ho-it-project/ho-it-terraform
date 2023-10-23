### HTTP common sg
resource "aws_security_group" "external_lb" {
  name        = "common-HTTP-external-lb-${data.terraform_remote_state.vpc.outputs.vpc_name}-ext"
  description = "common-HTTP-external-lb-${data.terraform_remote_state.vpc.outputs.vpc_name}-ext"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # Only allow access from IPs or SGs you specifiy in ext_lb_ingress_cidrs variables
  # If you don't want to use HTTPS then remove this block
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ext_lb_ingress_cidrs
    description = "External service https port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.github_hook_sg_ipv4_cidrs
    description = "External service https port"
  }

  ingress {
    from_port        = 433
    to_port          = 433
    protocol         = "tcp"
    ipv6_cidr_blocks = var.github_hook_sg_ipv6_cidrs
  }


  # Allow 80 port 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ext_lb_ingress_cidrs
    description = "External service http port"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Internal outbound any traffic"
  }

  tags = var.sg_variables.external_lb.tags[data.terraform_remote_state.vpc.outputs.shard_id]
}


resource "aws_security_group" "ec2" {
  name        = "common-ec2-${data.terraform_remote_state.vpc.outputs.vpc_name}"
  description = "common ec2 Instance Security Group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # Service Port will be passed via variable.
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    # Allow external LB Only for ec2 instance
    security_groups = [
      aws_security_group.external_lb.id,
    ]

    description = "Port Open for external LB"
  }
  ingress {
    from_port = 50000
    to_port   = 50000
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internal outbound traffic"
  }

  tags = {
    Name  = "common-ec2-${data.terraform_remote_state.vpc.outputs.vpc_name}-sg"
    stack = data.terraform_remote_state.vpc.outputs.vpc_name
  }
}


### API server

###### kafka sg  
## 개발편의상 private x 
# resource "aws_security_group" "kafka" {
#   name        = "kraft-kafka-${data.terraform_remote_state.vpc.outputs.vpc_name}"
#   description = "Kraft Kafka Broker Security Group"
#   vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

#   # INTERNAL Listener
#   ingress {
#     from_port   = 29092
#     to_port     = 29092
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Kafka INTERNAL Listener"
#   }

#   # CONTROLLER Listener
#   ingress {
#     from_port   = 29093
#     to_port     = 29093
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Kafka CONTROLLER Listener"
#   }

#   # EXTERNAL Listener
#   ingress {
#     from_port   = 9092
#     to_port     = 9092
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Kafka EXTERNAL Listener"
#   }

#   # Outbound rule
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     description = "Outbound Traffic"
#   }

#   tags = {
#     Name  = "kraft-kafka-${data.terraform_remote_state.vpc.outputs.vpc_name}-sg"
#     stack = data.terraform_remote_state.vpc.outputs.vpc_name
#   }
# }






