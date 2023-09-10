# app
locals {
  kafka_hosts = [
    for i in range(0, 3) : "kafka${i + 1}.ho-it.me"
  ]
}
locals {
  KAFKA_CONTROLLER_QUORUM_VOTERS = join(",", [for idx in range(3) : format("%d@%s:29093", idx + 1, element(local.kafka_hosts, idx))])
}

resource "aws_ecs_task_definition" "task-definition" {
  count  = var.broker_count
  family = "kafka${count.index + 1}"

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:type == kafka${count.index + 1}"
  }

  health_check {
    command      = ["CMD-SHELL", "docker ps -f name=kafka${count.index + 1} --format '{{.Names}}'"]
    interval     = 10
    retries      = 3
    start_period = 60
    timeout      = 5
  }
  container_definitions = templatefile("${path.module}/templates/app.json.tpl", {
    KAFKA_HOST_NAME                                = element(local.kafka_hosts, count.index)
    REPOSITORY_URL                                 = var.repository_url
    KAFKA_NUM                                      = count.index + 1
    KAFKA_CONTROLLER_QUORUM_VOTERS                 = local.KAFKA_CONTROLLER_QUORUM_VOTERS
    KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR         = 3
    KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR = 3
  })
}

resource "aws_ecs_service" "kafka" {
  count                              = var.broker_count
  name                               = "kafka${count.index + 1}"
  cluster                            = aws_ecs_cluster.kafka-cluster.id
  task_definition                    = element(aws_ecs_task_definition.task-definition.*.arn, count.index)
  desired_count                      = 1
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50



  load_balancer {
    target_group_arn = element(aws_lb_target_group.external_29092.*.arn, count.index)
    container_port   = 29092
    container_name   = "kafka${count.index + 1}"
  }

  load_balancer {
    target_group_arn = element(aws_lb_target_group.external_9092.*.arn, count.index)
    container_port   = 9092
    container_name   = "kafka${count.index + 1}"
  }

  load_balancer {
    target_group_arn = element(aws_lb_target_group.external_29093.*.arn, count.index)
    container_port   = 29093
    container_name   = "kafka${count.index + 1}"
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]
  }
  tags = {
    "Kafka" = count.index + 1
  }
}

