data "template_file" "init" {
  count    = var.broker_count
  template = file("${path.module}/scripts/userdata.sh")
  vars = {
    ecs_cluster_name = aws_ecs_cluster.kafka-cluster.name
    kafka_num        = count.index + 1
  }
}
