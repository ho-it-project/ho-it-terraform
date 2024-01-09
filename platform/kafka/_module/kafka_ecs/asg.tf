
resource "aws_ecs_cluster" "kafka-cluster" {
  name = "kafka-cluster"

}

# AWS Launch Configutaion
resource "aws_launch_configuration" "launch_configuration" {
  count         = var.broker_count
  image_id      = var.AWS_ECS_AMI
  instance_type = var.instance_size
  security_groups = [
    aws_security_group.ec2.id
  ]
  associate_public_ip_address = true

  user_data = element(data.template_file.init.*.rendered, count.index)

  key_name             = var.ssh_key_name
  iam_instance_profile = var.aws_iam_instance_profile_ecs_ec2_role_id



  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_ecs_service.kafka]
}


# Autoscaling group
# If you don't have NAT Gateway or NAT Instance, then you should use public_subnet for deployment
# BUT, using private subnet is recommended 
resource "aws_autoscaling_group" "autoscaling_group" {
  count               = var.broker_count
  vpc_zone_identifier = var.public_subnets
  # vpc_zone_identifier = var.private_subnets

  name                      = "${var.service_name}-${var.vpc_name}-kafka-${count.index + 1}"
  max_size                  = var.instance_count_max
  min_size                  = var.instance_count_min
  default_cooldown          = 60
  health_check_grace_period = 60
  health_check_type         = "EC2"
  desired_capacity          = var.instance_count_desired

  force_delete         = true
  launch_configuration = element(aws_launch_configuration.launch_configuration.*.name, count.index)
  # target_group_arns = [
  #   element(aws_lb_target_group.external_29093.*.arn, count.index),
  #   element(aws_lb_target_group.external_9092.*.arn, count.index),
  #   element(aws_lb_target_group.external_29092.*.arn, count.index)
  # ]


  lifecycle {
    ignore_changes = [desired_capacity]
  }

  tag {
    key                 = "Name"
    value               = "${var.service_name}-${var.vpc_name}-kafka-${count.index + 1}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Kafka"
    value               = count.index + 1
    propagate_at_launch = true

  }
  tag {
    key                 = "type"
    value               = "kafka${count.index + 1}"
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
  # depends_on = [aws_lb_target_group.external_29092
  #   , aws_lb_target_group.external_29093
  #   , aws_lb_target_group.external_9092

  # ]
}

# resource "aws_autoscaling_attachment" "web" {
#   autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
#   lb_target_group_arn    = aws_lb_target_group.internal.arn
# }
# target_group_arns = [
#   element(aws_lb_target_group.external_29093.*.arn, count.index),
#   element(aws_lb_target_group.external_9092.*.arn, count.index),
#   element(aws_lb_target_group.external_29092.*.arn, count.index)
# ]
# resource "aws_autoscaling_schedule" "scale_down" {
#   count                  = var.broker_count
#   scheduled_action_name  = "scale_down"
#   min_size               = 0
#   max_size               = 0
#   desired_capacity       = 0
#   recurrence             = "0 0 * * *"
#   time_zone              = "Asia/Seoul"
#   autoscaling_group_name = element(aws_autoscaling_group.autoscaling_group.*.name, count.index)
# }
# resource "aws_autoscaling_schedule" "scale_up" {
#   count                  = var.broker_count
#   scheduled_action_name  = "scale_up"
#   min_size               = 1
#   max_size               = 1
#   desired_capacity       = 1
#   recurrence             = "0 15 * * *"
#   time_zone              = "Asia/Seoul"
#   autoscaling_group_name = element(aws_autoscaling_group.autoscaling_group.*.name, count.index)

# }
