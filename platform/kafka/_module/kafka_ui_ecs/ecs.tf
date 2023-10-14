
resource "aws_ecs_task_definition" "task-definition" {

  family = "kafka-ui"

  container_definitions = templatefile("${path.module}/templates/app.json.tpl", {
    REPOSITORY_URL                    = var.repository_url,
    KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS = var.KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS
  })
}

resource "aws_ecs_service" "kafka-ui" {
  count           = var.MYAPP_SERVICE_ENABLED
  name            = "kafka-ui-server"
  cluster         = aws_ecs_cluster.kafka-ui-cluster.id
  task_definition = aws_ecs_task_definition.task-definition.arn
  desired_count   = 1

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  iam_role        = var.ecs_service_role_arn

  load_balancer {
    target_group_arn = aws_lb_target_group.external.arn
    container_name   = "kafka-ui"
    container_port   = var.SERVICE_PORT
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]
  }
}

