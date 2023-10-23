# app

resource "aws_ecs_task_definition" "api-server-task-definition" {
  family = "api-server"
  container_definitions = templatefile("./templates/app.json.tpl", {
    REPOSITORY_URL = replace(data.terraform_remote_state.api-server-ecr.outputs.ecr_url, "https://", "")
  })
}

resource "aws_ecs_service" "api-server" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = "api-serverr"
  cluster         = aws_ecs_cluster.api-server-cluster.id
  task_definition = aws_ecs_task_definition.api-server-task-definition.arn
  desired_count   = 1
  iam_role        = data.terraform_remote_state.iam.outputs.aws_iam_role_ecs_service_role_arn


  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50

  load_balancer {
    target_group_arn = data.terraform_remote_state.alb.outputs.api_server_lb_tg.arn

    container_name = "api-server"
    container_port = var.SERVICE_PORT

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
