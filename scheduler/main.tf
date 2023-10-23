module "stop_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_stop"
  cloudwatch_schedule_expression = "cron(0 0 ? * FRI *)"
  schedule_action                = "stop"
  autoscaling_schedule           = "false"
  documendb_schedule             = "false"
  ec2_schedule                   = "true"
  ecs_schedule                   = "false"
  rds_schedule                   = "false"
  redshift_schedule              = "false"
  cloudwatch_alarm_schedule      = "false"
  scheduler_tag                  = {
    key   = "tostop"
    value = "true"
  }
}

module "start_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_start"
  cloudwatch_schedule_expression = "cron(0 8 ? * MON *)"
  schedule_action                = "start"
  autoscaling_schedule           = "false"
  documendb_schedule             = "false"
  ec2_schedule                   = "true"
  ecs_schedule                   = "false"
  rds_schedule                   = "false"
  redshift_schedule              = "false"
  cloudwatch_alarm_schedule      = "false"
  scheduler_tag                  = {
    key   = "tostop"
    value = "true"
  }
}
