# app

resource "aws_ecs_task_definition" "api-server-task-definition" {
  family = "api-server"
  container_definitions = templatefile("./templates/app.json.tpl", {
    REPOSITORY_URL = replace(data.terraform_remote_state.api-server-ecr.outputs.ecr_url, "https://", "")
  })
}

resource "aws_ecs_service" "api-server" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = "api-server"
  cluster         = aws_ecs_cluster.api-server-cluster.id
  task_definition = aws_ecs_task_definition.api-server-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn


  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50

  load_balancer {
    target_group_arn = module.api-server.aws_lb_target_group_arn
    container_name   = "api-server"
    container_port   = 8000
  }

  health_check_grace_period_seconds = 300
  health_check_path                 = "/api"
  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]

  }
}
