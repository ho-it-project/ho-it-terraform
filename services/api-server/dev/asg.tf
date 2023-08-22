resource "aws_ecs_cluster" "api-server" {
  name = "api-server-cluster"
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
  name_prefix     = "api-server-"
  image_id        = var.AWS_AMI_LIST["ubuntu_20_04_x86"]
  instance_type   = var.instance_type["t3micro"]
  security_groups = [module.api-server.aws_security_group_ec2_id]

  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${aws_ecs_cluster.api-server.name} >> /etc/ecs/ecs.config\nstart ecs
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs-autoscaling_group" {

  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.public_subnets

  name             = "api-server-autoscaling-group"
  max_size         = 1
  min_size         = 1
  desired_capacity = 1
  default_cooldown = 60

  launch_configuration = aws_launch_configuration.ecs-launch-configuration.name

  force_delete      = true
  target_group_arns = [module.api-server.aws_lb_target_group_arn]


  tag {
    key                 = "Name"
    value               = "api-server-autoscaling-group"
    propagate_at_launch = true
  }
}

