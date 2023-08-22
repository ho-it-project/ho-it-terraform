# app

resource "aws_ecs_task_definition" "api-server-task-definition" {
  family = "myapp"
  container_definitions = templatefile("templates/app.json.tpl", {
    REPOSITORY_URL = replace(data.terraform_remote_state.ecr.outputs.ecr_url, "https://", "")
  })
}

resource "aws_ecs_service" "api-server" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = "api-server"
  cluster         = aws_ecs_cluster.api-server.id
  task_definition = aws_ecs_task_definition.api-server-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_policy_attachment.ecs-service-attach]


  lifecycle {
    ignore_changes = [task_definition]
  }
}
