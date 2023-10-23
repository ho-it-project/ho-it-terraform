// ALB
resource "aws_lb" "external" {
  name     = "hoit-nlb-${data.terraform_remote_state.vpc.outputs.shard_id}-ext"
  subnets  = data.terraform_remote_state.vpc.outputs.public_subnets
  internal = false

  # For external LB,
  # Home SG (Includes Office IPs) could be added if this service is internal service.
  security_groups = [
    aws_security_group.kafka.id,
  ]

  # For HTTP service, application LB is recommended.
  # You could use other load_balancer_type if you want.
  load_balancer_type = "network"

  tags = var.lb_variables.external_lb.tags[data.terraform_remote_state.vpc.outputs.shard_id]
}



