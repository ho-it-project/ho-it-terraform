# app
locals {
  kafka_hosts = [
    for i in range(0, var.broker_count) : "broker${i + 1}.ho-it.kafka"
  ]
}
locals {
  KAFKA_CONTROLLER_QUORUM_VOTERS = join(",", [for idx in range(var.broker_count) : format("%d@%s:29093", idx + 1, element(local.kafka_hosts, idx))])
}

resource "aws_ecs_task_definition" "task-definition" {
  count        = var.broker_count
  family       = "kafka${count.index + 1}"
  network_mode = "awsvpc"
  placement_constraints {
    type       = "memberOf"
    expression = "attribute:type == kafka${count.index + 1}"
  }

  container_definitions = templatefile("${path.module}/templates/app.json.tpl", {
    KAFKA_HOST_NAME                                = local.kafka_hosts[count.index]
    REPOSITORY_URL                                 = var.repository_url
    KAFKA_NUM                                      = count.index + 1
    KAFKA_CONTROLLER_QUORUM_VOTERS                 = local.KAFKA_CONTROLLER_QUORUM_VOTERS
    KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR         = var.broker_count
    KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR = var.broker_count
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

  network_configuration {
    subnets         = concat(var.private_subnets)
    security_groups = [aws_security_group.ec2.id, aws_security_group.kafka.id]
  }

  service_registries {
    registry_arn = element(aws_service_discovery_service.kafka.*.arn, count.index)

  }



  lifecycle {
    ignore_changes = [
      task_definition,
    ]
  }

  tags = {
    "Kafka" = count.index + 1
  }
}

resource "aws_service_discovery_private_dns_namespace" "kafka" {
  name = "ho-it.kafka"
  vpc  = var.target_vpc
}

resource "aws_service_discovery_service" "kafka" {
  count = var.broker_count

  name = "broker${count.index + 1}"

  dns_config {

    namespace_id   = aws_service_discovery_private_dns_namespace.kafka.id
    routing_policy = "WEIGHTED"
    dns_records {
      ttl  = 10
      type = "A"

    }

  }
  health_check_custom_config {
    failure_threshold = 1
  }
}

