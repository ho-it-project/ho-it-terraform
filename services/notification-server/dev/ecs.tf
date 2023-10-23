# app

resource "aws_ecs_task_definition" "notification-server-task-definition" {
  family = "notification-server"
  container_definitions = templatefile("./templates/app.json.tpl", {
    REPOSITORY_URL = replace(data.terraform_remote_state.notification-server-ecr.outputs.ecr_url, "https://", "")
  })
  # health_check {
  #   command      = ["CMD-SHELL", "curl -f http://localhost:${var.SERVICE_PORT}/health || exit 1"]
  #   interval     = 10
  #   retries      = 3
  #   start_period = 60
  #   timeout      = 5
  # }
}

resource "aws_ecs_service" "notification-server" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = "notification-server"
  cluster         = aws_ecs_cluster.notification-server-cluster.id
  task_definition = aws_ecs_task_definition.notification-server-task-definition.arn
  desired_count   = 1
  iam_role        = data.terraform_remote_state.iam.outputs.aws_iam_role_ecs_service_role_arn


  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50

  load_balancer {
    target_group_arn = data.terraform_remote_state.alb.outputs.notification_server_lb_tg.arn
    container_name   = "notification-server"
    container_port   = var.SERVICE_PORT
    # health_check = {
    #   path                = "/api/health"
    #   interval            = 10
    #   timeout             = 5
    #   healthy_threshold   = 2
    #   unhealthy_threshold = 2
    # }
  }

  # health_check_grace_period_seconds = 300
  # health_check_path                 = "/api"
  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]

  }
}
