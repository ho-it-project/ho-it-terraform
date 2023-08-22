resource "aws_ecs_cluster" "api-server-cluster" {
  name = "api-server-cluster"
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
  name_prefix     = "api-server-"
  image_id        = var.AWS_ECS_AMI
  instance_type   = var.EC2_TYPE["t3micro"]
  security_groups = [module.api-server.aws_security_group_ec2_id]

  associate_public_ip_address = true
  key_name                    = var.SSH_KEY_NAME
  iam_instance_profile        = aws_iam_instance_profile.ecs-ec2-role.id
  user_data                   = data.template_file.init.rendered
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

