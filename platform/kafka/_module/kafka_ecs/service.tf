
# resource "aws_security_group" "external_lb" {
#   name        = "${var.service_name}-${var.vpc_name}-ext"
#   description = "${var.service_name} external LB SG"
#   vpc_id      = var.target_vpc

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = var.ext_lb_ingress_cidrs
#   }
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = var.ext_lb_ingress_cidrs
#     description = "External service http port"
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["10.0.0.0/8"]
#   }


#   tags = var.sg_variables.external_lb.tags[var.shard_id]
# }


############ Security Group 
resource "aws_security_group" "kafka" {
  name        = "${var.service_name}-kraft-kafka-${var.vpc_name}"
  description = "Kraft Kafka Broker Security Group"
  vpc_id      = var.target_vpc

  # INTERNAL Listener
  ingress {
    from_port   = 29092
    to_port     = 29092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Kafka INTERNAL Listener"
  }

  # CONTROLLER Listener
  ingress {
    from_port   = 29093
    to_port     = 29093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Kafka CONTROLLER Listener"
  }

  # EXTERNAL Listener
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Kafka EXTERNAL Listener"
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound Traffic"
  }

  tags = {
    Name  = "${var.service_name}-kraft-kafka-${var.vpc_name}-sg"
    app   = var.service_name
    stack = var.vpc_name
  }
}



################## Security Group for ec2
resource "aws_security_group" "ec2" {
  name        = "${var.service_name}-${var.vpc_name}"
  description = "${var.service_name} Instance Security Group"
  vpc_id      = var.target_vpc


  # Service Port will be passed via variable.
  # ingress {
  #   from_port = 433
  #   to_port   = 433
  #   protocol  = "tcp"
  #   security_groups = [
  #     var.ssm_vpc_endpoint_sg
  #   ]
  # }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    security_groups = [
      # aws_security_group.external_lb.id,
      aws_security_group.kafka.id,
    ]

    description = "Port Open for ${var.service_name}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internal outbound traffic"
  }

  tags = {
    Name  = "${var.service_name}-${var.vpc_name}-sg"
    app   = var.service_name
    stack = var.vpc_name
  }
  depends_on = [aws_security_group.kafka]

}

# resource "aws_lb" "internal" {
#   name     = "${var.service_name}--${var.shard_id}-int"
#   subnets  = var.public_subnets
#   internal = true

#   # Home SG (Includes Office IPs) could be added if this service is internal service.
#   security_groups = [aws_security_group.kafka.id, var.home_sg]

#   # For HTTP service, application LB is recommended.
#   # You could use other load_balancer_type if you want.
#   load_balancer_type = "application"

#   tags = var.lb_variables.internal_lb.tags[var.shard_id]
# }

# #################### Internal LB Target Group 
# resource "aws_lb_target_group" "internal" {
#   name     = "${var.service_name}-${var.shard_id}-int"
#   port     = 9092
#   protocol = "HTTP"


#   vpc_id               = var.target_vpc
#   slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
#   deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]
#   # Change the health check setting 
#   health_check {
#     enabled             = true
#     interval            = 30
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#   }

#   tags = var.lb_variables.internal_lb_tg.tags[var.shard_id]

# }


#################### Route53 Record
# resource "aws_route53_record" "internal_dns" {

#   zone_id        = var.route53_internal_zone_id
#   name           = var.domain_name
#   type           = "A"
#   set_identifier = var.aws_region

#   latency_routing_policy {
#     region = var.aws_region
#   }

#   alias {
#     name                   = aws_lb.internal.dns_name
#     zone_id                = aws_lb.internal.zone_id
#     evaluate_target_health = true
#   }
# }


resource "aws_lb" "external" {
  count    = var.broker_count
  name     = "${var.service_name}-${var.shard_id}-ext-kafka-${count.index + 1}"
  subnets  = var.public_subnets
  internal = false

  # For external LB,
  # Home SG (Includes Office IPs) could be added if this service is internal service.
  security_groups = [
    # aws_security_group.external_lb.id,
    aws_security_group.kafka.id,
    var.home_sg,
  ]

  # For HTTP service, application LB is recommended.
  # You could use other load_balancer_type if you want.
  load_balancer_type = "network"

  tags       = var.lb_variables.external_lb.tags[var.shard_id]
  depends_on = [aws_security_group.kafka]
}

resource "aws_lb_target_group" "external_9092" {
  count = var.broker_count
  name  = "${var.service_name}-${var.shard_id}-ext-9092-kafka-${count.index + 1}"
  port  = 9092


  protocol             = "TCP"
  vpc_id               = var.target_vpc
  slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]
  # Change the health check setting 


  tags = var.lb_variables.external_lb_tg.tags[var.shard_id]

  health_check {
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 6
    interval            = 300
  }
  depends_on = [aws_lb.external]
}


resource "aws_lb_target_group" "external_29092" {
  count = var.broker_count
  name  = "${var.service_name}-${var.shard_id}-ext-29092-kafka-${count.index + 1}"
  port  = 29092


  protocol             = "TCP"
  vpc_id               = var.target_vpc
  slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]
  # Change the health check setting 


  tags = var.lb_variables.external_lb_tg.tags[var.shard_id]

  health_check {
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 6
    interval            = 300
  }
  depends_on = [aws_lb.external]
}


resource "aws_lb_target_group" "external_29093" {
  count = var.broker_count
  name  = "${var.service_name}-${var.shard_id}-ext-29093-kafka-${count.index + 1}"
  port  = 29093


  protocol             = "TCP"
  vpc_id               = var.target_vpc
  slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]
  # Change the health check setting 


  tags = var.lb_variables.external_lb_tg.tags[var.shard_id]

  health_check {
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 6
    interval            = 300
  }
  depends_on = [aws_lb.external]
}


resource "aws_lb_listener" "external_9092" {
  count             = var.broker_count
  load_balancer_arn = element(aws_lb.external.*.arn, count.index)
  port              = "9092"
  protocol          = "TCP"
  default_action {
    target_group_arn = element(aws_lb_target_group.external_9092.*.arn, count.index)
    type             = "forward"
  }
  depends_on = [aws_lb_target_group.external_9092]
}

resource "aws_lb_listener" "external_29092" {
  count             = var.broker_count
  load_balancer_arn = element(aws_lb.external.*.arn, count.index)
  port              = "29092"
  protocol          = "TCP"
  default_action {
    target_group_arn = element(aws_lb_target_group.external_29092.*.arn, count.index)
    type             = "forward"
  }
  depends_on = [aws_lb_target_group.external_29092]
}

resource "aws_lb_listener" "external_29093" {
  count             = var.broker_count
  load_balancer_arn = element(aws_lb.external.*.arn, count.index)
  port              = "29093"
  protocol          = "TCP"
  default_action {
    target_group_arn = element(aws_lb_target_group.external_29093.*.arn, count.index)
    type             = "forward"
  }
  depends_on = [aws_lb_target_group.external_29093]
}

# resource "aws_lb_listener" "external_443" {
#   count             = var.broker_count
#   load_balancer_arn = element(aws_lb.external.*.arn, count.index)
#   port              = "443"
#   protocol          = "HTTPS"


#   # If you want to use HTTPS, then you need to add certificate_arn here.
#   certificate_arn = var.acm_external_ssl_certificate_arn

#   default_action {
#     target_group_arn = element(aws_lb_target_group.external.*.arn, count.index)
#     type             = "forward"
#   }
# }

# resource "aws_lb_listener" "external_80" {
#   count             = var.broker_count
#   load_balancer_arn = element(aws_lb.external.*.arn, count.index)
#   port              = "80"
#   protocol          = "HTTP"

#   # This is for redirect 80. 
#   # This means that it will only allow HTTPS(443) traffic
#   default_action {
#     type = "redirect"

#     redirect {
#       port     = "443"
#       protocol = "HTTPS"
#       # 301 -> Permanant Movement
#       status_code = "HTTP_301"
#     }
#   }
# }

resource "aws_route53_record" "external_dns" {
  count          = var.broker_count
  zone_id        = var.route53_external_zone_id
  name           = "${var.domain_name}${count.index + 1}"
  type           = "A"
  set_identifier = var.aws_region

  latency_routing_policy {
    region = var.aws_region
  }

  alias {
    name                   = element(aws_lb.external.*.dns_name, count.index)
    zone_id                = element(aws_lb.external.*.zone_id, count.index)
    evaluate_target_health = false
  }
  depends_on = [aws_lb.external]
}



# output "aws_route53_record_fqdns" {
#   value = aws_route53_record.internal_dns.fqdn
# }

# output "aws_route53_record_name" {
#   value = aws_route53_record.internal_dns.name
# }
