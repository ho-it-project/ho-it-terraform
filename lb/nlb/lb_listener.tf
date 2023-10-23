
### kafka ======= ALB 사용불가
resource "aws_lb_listener" "kafka-9092" {
  count             = var.kafka_broker_count
  load_balancer_arn = aws_lb.external.arn
  port              = "9092"
  protocol          = "TCP"
  default_action {
    target_group_arn = element(aws_lb_target_group.kafka-9092.*.arn, count.index)
    type             = "forward"
  }
  depends_on = [aws_lb_target_group.kafka-9092]
}

resource "aws_lb_listener" "kafka-29092" {
  count             = var.kafka_broker_count
  load_balancer_arn = aws_lb.external.arn
  port              = "29092"
  protocol          = "TCP"
  default_action {
    target_group_arn = element(aws_lb_target_group.kafka-29092.*.arn, count.index)
    type             = "forward"
  }
  depends_on = [aws_lb_target_group.kafka-29092]
}

resource "aws_lb_listener" "kafka-29093" {
  count             = var.kafka_broker_count
  load_balancer_arn = aws_lb.external.arn
  port              = "29093"
  protocol          = "TCP"
  default_action {
    target_group_arn = element(aws_lb_target_group.kafka-29093.*.arn, count.index)
    type             = "forward"
  }
  depends_on = [aws_lb_target_group.kafka-29093]
}
