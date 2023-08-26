module "ems-front" {
  source = "../../_module/_server"

  service_name             = "hoit-ems-front"
  service_port             = var.SERVICE_PORT
  healthcheck_port         = var.SERVICE_PORT
  shard_id                 = data.terraform_remote_state.vpc.outputs.shard_id
  public_subnets           = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
  aws_region               = data.terraform_remote_state.vpc.outputs.aws_region
  vpc_cidr_numeral         = data.terraform_remote_state.vpc.outputs.cidr_numeral
  route53_internal_domain  = data.terraform_remote_state.vpc.outputs.route53_internal_domain
  route53_internal_zone_id = data.terraform_remote_state.vpc.outputs.route53_internal_zone_id
  target_vpc               = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name                 = data.terraform_remote_state.vpc.outputs.vpc_name
  billing_tag              = data.terraform_remote_state.vpc.outputs.billing_tag

  domain_name = "ems"

  acm_external_ssl_certificate_arn = var.r53_variables.ho-it_me_ssl
  route53_external_zone_id         = var.r53_variables.ho-it_me_zone_id

  lb_variables = var.lb_variables

  sg_variables = var.sg_variables

  home_sg = data.terraform_remote_state.vpc.outputs.aws_security_group_home_id


  ext_lb_ingress_cidrs = ["0.0.0.0/0"]
}
