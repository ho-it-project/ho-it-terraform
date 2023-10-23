output "ext_nlb" {
  value = aws_lb.external
}

output "kafka_29092_tg_list" {
  value = aws_lb_listener.kafka-29092
}

output "kafka_29093_tg_list" {
  value = aws_lb_listener.kafka-29093
}


output "kafka_9092_tg_list" {
  value = aws_lb_listener.kafka-9092
}
