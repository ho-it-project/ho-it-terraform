# #################### Route53 Record
resource "aws_route53_record" "api-server" {
  zone_id        = var.r53_variables.ho-it_me_zone_id
  name           = "api"
  type           = "A"
  set_identifier = var.AWS_REGION

  latency_routing_policy {
    region = var.AWS_REGION
  }

  alias {
    name                   = data.terraform_remote_state.alb.outputs.ext_alb.dns_name
    zone_id                = data.terraform_remote_state.alb.outputs.ext_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "notification-server" {
  zone_id        = var.r53_variables.ho-it_me_zone_id
  name           = "notification"
  type           = "A"
  set_identifier = var.AWS_REGION

  latency_routing_policy {
    region = var.AWS_REGION
  }

  alias {
    name                   = data.terraform_remote_state.alb.outputs.ext_alb.dns_name
    zone_id                = data.terraform_remote_state.alb.outputs.ext_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "er-front" {
  zone_id        = var.r53_variables.ho-it_me_zone_id
  name           = "er"
  type           = "A"
  set_identifier = var.AWS_REGION

  latency_routing_policy {
    region = var.AWS_REGION
  }

  alias {
    name                   = data.terraform_remote_state.alb.outputs.ext_alb.dns_name
    zone_id                = data.terraform_remote_state.alb.outputs.ext_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ems-front" {
  zone_id        = var.r53_variables.ho-it_me_zone_id
  name           = "ems"
  type           = "A"
  set_identifier = var.AWS_REGION

  latency_routing_policy {
    region = var.AWS_REGION
  }
  alias {
    name                   = data.terraform_remote_state.alb.outputs.ext_alb.dns_name
    zone_id                = data.terraform_remote_state.alb.outputs.ext_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "jenkins" {
  zone_id        = var.r53_variables.ho-it_me_zone_id
  name           = "jenkins"
  type           = "A"
  set_identifier = var.AWS_REGION

  latency_routing_policy {
    region = var.AWS_REGION
  }
  alias {
    name                   = data.terraform_remote_state.alb.outputs.ext_alb.dns_name
    zone_id                = data.terraform_remote_state.alb.outputs.ext_alb.zone_id
    evaluate_target_health = true
  }
}



#######################

# resource "aws_route53_record" "external_dns" {
#   count          = var.kafka_broker_count
#   zone_id        = var.route53_external_zone_id
#   name           = "$kafka${count.index + 1}"
#   type           = "A"
#   set_identifier = var.AWS_REGION

#   latency_routing_policy {
#     region = var.AWS_REGION
#   }

#   alias {
#     name                   = data.terraform_remote_state.nlb.outputs.ext_nlb.dns_name
#     zone_id                = data.terraform_remote_state.nlb.outputs.ext_nlb.zone_id
#     evaluate_target_health = false
#   }
#   depends_on = [aws_lb.external]
# }
