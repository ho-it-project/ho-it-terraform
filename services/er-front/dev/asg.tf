resource "aws_ecs_cluster" "er-front-cluster" {
  name = "er-front-cluster"
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
  name_prefix     = "er-front-"
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

  name             = "er-front-autoscaling-group"
  max_size         = 2
  min_size         = 1
  desired_capacity = 1
  default_cooldown = 60

  launch_configuration = aws_launch_configuration.ecs-launch-configuration.name

  force_delete      = true
  target_group_arns = [data.terraform_remote_state.alb.outputs.er_front_lb_tg.arn]

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "er-front-autoscaling-group"
    propagate_at_launch = true
  }


}


# resource "aws_autoscaling_schedule" "scale_down" {
#   scheduled_action_name  = "scale_down"
#   min_size               = 0
#   max_size               = 0
#   desired_capacity       = 0
#   recurrence             = "0 0 * * *"
#   time_zone              = "Asia/Seoul"
#   autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling_group.name
# }
# resource "aws_autoscaling_schedule" "scale_up" {
#   scheduled_action_name  = "scale_up"
#   min_size               = 1
#   max_size               = 1
#   desired_capacity       = 1
#   recurrence             = "10 15 * * *"
#   time_zone              = "Asia/Seoul"
#   autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling_group.name
# }


