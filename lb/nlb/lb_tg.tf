


## kafka ====== ALB 사용불가
resource "aws_lb_target_group" "kafka-9092" {
  count = var.kafka_broker_count
  name  = "kafka-9092-${data.terraform_remote_state.vpc.outputs.shard_id}-${count.index + 1}"
  port  = 9092


  protocol             = "TCP"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  slow_start           = var.lb_variables.target_group_slow_start[data.terraform_remote_state.vpc.outputs.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[data.terraform_remote_state.vpc.outputs.shard_id]
  # Change the health check setting 


  tags = var.lb_variables.external_lb_tg.tags[data.terraform_remote_state.vpc.outputs.shard_id]["kafka-9092"]


  health_check {
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 6
    interval            = 300
  }
  depends_on = [aws_lb.external]
}


resource "aws_lb_target_group" "kafka-29092" {
  count = var.kafka_broker_count
  name  = "kafka-29092-${data.terraform_remote_state.vpc.outputs.shard_id}-${count.index + 1}"
  port  = 29092


  protocol             = "TCP"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  slow_start           = var.lb_variables.target_group_slow_start[data.terraform_remote_state.vpc.outputs.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[data.terraform_remote_state.vpc.outputs.shard_id]
  # Change the health check setting 


  tags = var.lb_variables.external_lb_tg.tags[data.terraform_remote_state.vpc.outputs.shard_id]["kafka-29092"]

  health_check {
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 6
    interval            = 300
  }
  depends_on = [aws_lb.external]
}


resource "aws_lb_target_group" "kafka-29093" {
  count = var.kafka_broker_count
  name  = "kafka-29093-${data.terraform_remote_state.vpc.outputs.shard_id}-${count.index + 1}"
  port  = 29093


  protocol             = "TCP"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  slow_start           = var.lb_variables.target_group_slow_start[data.terraform_remote_state.vpc.outputs.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[data.terraform_remote_state.vpc.outputs.shard_id]
  # Change the health check setting 


  tags = var.lb_variables.external_lb_tg.tags[data.terraform_remote_state.vpc.outputs.shard_id]["kafka-29093"]

  health_check {
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 6
    interval            = 300
  }
  depends_on = [aws_lb.external]
}
