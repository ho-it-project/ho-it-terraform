
##### kafka ======= ALB 사용불가
### nlb - rule are unsupported
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
