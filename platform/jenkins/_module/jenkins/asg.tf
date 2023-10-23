
# AWS Launch Configutaion
resource "aws_launch_configuration" "launch_configuration" {
  image_id      = var.instance_ami
  instance_type = var.instance_size

  security_groups = [
    var.ec2_sg
  ]

  associate_public_ip_address = true

  user_data = data.template_file.init.rendered

  key_name             = var.ssh_key_name
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name


  lifecycle {
    create_before_destroy = true
  }
}


# Autoscaling group
# If you don't have NAT Gateway or NAT Instance, then you should use public_subnet for deployment
# BUT, using private subnet is recommended 
resource "aws_autoscaling_group" "autoscaling_group" {
  # vpc_zone_identifier = var.private_subnets
  vpc_zone_identifier = var.public_subnets

  name                      = "${var.service_name}-master-${var.vpc_name}"
  max_size                  = var.instance_count_max
  min_size                  = var.instance_count_min
  default_cooldown          = 60
  health_check_grace_period = 60
  health_check_type         = "EC2"

  desired_capacity = var.instance_count_desired

  force_delete         = true
  launch_configuration = aws_launch_configuration.launch_configuration.name

  target_group_arns = [var.lb_tg_arn]

  lifecycle {
    ignore_changes = [desired_capacity]
  }
  tag {
    key                 = "Name"
    value               = "${var.service_name}-master-${var.vpc_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "first_owner"
    value               = var.tag_first_owner
    propagate_at_launch = true
  }

  tag {
    key                 = "project"
    value               = var.tag_project
    propagate_at_launch = true
  }
}





resource "aws_autoscaling_schedule" "scale_down" {
  scheduled_action_name  = "scale_down"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = "0 3 * * *"
  time_zone              = "Asia/Seoul"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}
resource "aws_autoscaling_schedule" "scale_up" {
  scheduled_action_name  = "scale_up"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  recurrence             = "0 21 * * *"
  time_zone              = "Asia/Seoul"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

