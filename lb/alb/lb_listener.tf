
############### ALB Listener
resource "aws_lb_listener" "external_443" {
  load_balancer_arn = aws_lb.external.arn
  port              = "443"
  protocol          = "HTTPS"


  # If you want to use HTTPS, then you need to add certificate_arn here.
  certificate_arn = var.r53_variables.ho-it_me_ssl
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}


#################### Listener for HTTP service
resource "aws_lb_listener" "external_80" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"

  # This is for redirect 80. 
  # This means that it will only allow HTTPS(443) traffic
  default_action {
    type = "redirect"

    redirect {
      port     = "443"
      protocol = "HTTPS"
      # 301 -> Permanant Movement
      status_code = "HTTP_301"
    }
  }
}


# ### kafka ======= ALB 사용불가
# resource "aws_lb_listener" "kafka-9092" {
#   count             = var.kafka_broker_count
#   load_balancer_arn = aws_lb.external.arn
#   port              = "9092"
#   protocol          = "TCP"
#   default_action {
#     target_group_arn = element(aws_lb_target_group.kafka-9092.*.arn, count.index)
#     type             = "forward"
#   }
#   depends_on = [aws_lb_target_group.kafka-9092]
# }

# resource "aws_lb_listener" "kafka-29092" {
#   count             = var.kafka_broker_count
#   load_balancer_arn = aws_lb.external.arn
#   port              = "29092"
#   protocol          = "TCP"
#   default_action {
#     target_group_arn = element(aws_lb_target_group.kafka-29092.*.arn, count.index)
#     type             = "forward"
#   }
#   depends_on = [aws_lb_target_group.kafka-29092]
# }

# resource "aws_lb_listener" "kafka-29093" {
#   count             = var.kafka_broker_count
#   load_balancer_arn = aws_lb.external.arn
#   port              = "29093"
#   protocol          = "TCP"
#   default_action {
#     target_group_arn = element(aws_lb_target_group.kafka-29093.*.arn, count.index)
#     type             = "forward"
#   }
#   depends_on = [aws_lb_target_group.kafka-29093]
# }
