resource "aws_ecs_cluster" "ems-front-cluster" {
  name = "ems-front-cluster"
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
  name_prefix     = "ems-front-"
  image_id        = var.AWS_ECS_AMI
  instance_type   = var.EC2_TYPE["t3micro"]
  security_groups = [data.terraform_remote_state.alb.outputs.ec2_sg.id]

  associate_public_ip_address = true
  key_name                    = var.SSH_KEY_NAME

  iam_instance_profile = data.terraform_remote_state.iam.outputs.aws_iam_instance_profile_ecs_ec2_role_id
  user_data            = data.template_file.init.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs-autoscaling_group" {

  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.public_subnets

  name             = "ems-front-autoscaling-group"
  max_size         = 2
  min_size         = 1
  desired_capacity = 1
  default_cooldown = 60

  launch_configuration = aws_launch_configuration.ecs-launch-configuration.name

  force_delete      = true
  target_group_arns = [data.terraform_remote_state.alb.outputs.ems_front_tg.arn]

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "ems-front-autoscaling-group"
    propagate_at_launch = true
  }


}

