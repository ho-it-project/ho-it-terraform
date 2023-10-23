

#######################
# ALB Listener Rules
#######################

### API Server
resource "aws_lb_listener_rule" "api-server" {
  listener_arn = aws_lb_listener.external_443.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api-server.arn
  }

  condition {
    host_header {
      values = ["api.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
    }
  }
}


### Notification Server
resource "aws_lb_listener_rule" "notification-server" {
  listener_arn = aws_lb_listener.external_443.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notification-server.arn
  }

  condition {
    host_header {
      values = ["notification.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
    }
  }
}


### ER Front
resource "aws_lb_listener_rule" "er-front" {
  listener_arn = aws_lb_listener.external_443.arn
  priority     = 300

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.er-front.arn
  }

  condition {
    host_header {
      values = ["er.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
    }
  }
}


### EMS Front
resource "aws_lb_listener_rule" "ems-front" {
  listener_arn = aws_lb_listener.external_443.arn
  priority     = 400

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ems-front.arn
  }

  condition {
    host_header {
      values = ["ems.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
    }
  }
}



###### CICD 
### Jenkins 
resource "aws_lb_listener_rule" "jenkins" {
  listener_arn = aws_lb_listener.external_443.arn
  priority     = 500

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }

  condition {
    host_header {
      values = ["jenkins.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
    }
  }

}




###### kafka ======= ALB 사용불가
# resource "aws_lb_listener_rule" "kafka-9092" {
#   count        = var.kafka_broker_count
#   listener_arn = element(aws_lb_listener.kafka-9092.*.arn, count.index)
#   priority     = 600 + count.index

#   action {
#     type             = "forward"
#     target_group_arn = element(aws_lb_target_group.kafka-9092.*.arn, count.index)
#   }
#   condition {
#     host_header {
#       values = ["kafka${count.index + 1}.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
#     }
#   }

# }
# resource "aws_lb_listener_rule" "kafka-29092" {
#   count        = var.kafka_broker_count
#   listener_arn = element(aws_lb_listener.kafka-29092.*.arn, count.index)
#   priority     = 600 + count.index

#   action {
#     type             = "forward"
#     target_group_arn = element(aws_lb_target_group.kafka-29092.*.arn, count.index)
#   }
#   condition {
#     host_header {
#       values = ["kafka${count.index + 1}.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
#     }
#   }

# }
# resource "aws_lb_listener_rule" "kafka-29093" {
#   count        = var.kafka_broker_count
#   listener_arn = element(aws_lb_listener.kafka-29093.*.arn, count.index)
#   priority     = 600 + count.index

#   action {
#     type             = "forward"
#     target_group_arn = element(aws_lb_target_group.kafka-29093.*.arn, count.index)
#   }

#   condition {
#     host_header {
#       values = ["kafka${count.index + 1}.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"]
#     }
#   }
# }
