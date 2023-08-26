data "template_file" "init" {
  template = file("./scripts/userdata.sh")
  vars = {
    ecs_cluster_name = aws_ecs_cluster.ems-front-cluster.name
  }
}
