output "ext_alb" {
  value = aws_lb.external
}

output "api_server_lb_tg" {
  value = aws_lb_target_group.api-server
}

output "notification_server_lb_tg" {
  value = aws_lb_target_group.notification-server
}

output "er_front_lb_tg" {
  value = aws_lb_target_group.er-front
}

output "ems_front_tg" {
  value = aws_lb_target_group.ems-front
}

output "jenkins_tg" {
  value = aws_lb_target_group.jenkins
}

output "ec2_sg" {
  value = aws_security_group.ec2
}
# output "kafka_29092_tg_list" {
#   value = aws_lb_listener.kafka-29092
# }

# output "kafka_29093_tg_list" {
#   value = aws_lb_listener.kafka-29093
# }


# output "kafka_9092_tg_list" {
#   value = aws_lb_listener.kafka-9092
# }
