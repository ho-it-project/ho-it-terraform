data "template_file" "init" {
  template = file("${path.module}/scripts/userdata.sh")
  vars = {
    aws_account_id   = var.account_id
    ecs_cluster_name = aws_ecs_cluster.kafka-ui-cluster.name
  }
}

