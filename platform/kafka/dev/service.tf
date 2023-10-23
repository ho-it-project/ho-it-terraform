module "kafka" {
  source       = "../_module/kafka_ecs"
  service_name = "kafka"
  account_id   = var.ACCOUNT_ID
  broker_count = 3
  domain_name  = "kafka"
  domain       = "ho-it.me"

  tag_project     = "kafka"
  instance_size   = "t3a.micro"
  shard_id        = data.terraform_remote_state.vpc.outputs.shard_id
  public_subnets  = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets

  aws_region                       = data.terraform_remote_state.vpc.outputs.aws_region
  vpc_cidr_numeral                 = data.terraform_remote_state.vpc.outputs.cidr_numeral
  route53_internal_domain          = data.terraform_remote_state.vpc.outputs.route53_internal_domain
  route53_internal_zone_id         = data.terraform_remote_state.vpc.outputs.route53_internal_zone_id
  target_vpc                       = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name                         = data.terraform_remote_state.vpc.outputs.vpc_name
  billing_tag                      = data.terraform_remote_state.vpc.outputs.billing_tag
  acm_external_ssl_certificate_arn = var.r53_variables.ho-it_me_ssl
  route53_external_zone_id         = var.r53_variables.ho-it_me_zone_id
  # ssm_vpc_endpoint_sg   = data.terraform_remote_state.vpc.outputs.ssm_vpc_endpoint_sg
  ssm_vpc_endpoint_sg = ""
  # vpc_endpoint_ssm_id   = data.terraform_remote_state.vpc.outputs.vpc_endpoint_ssm_id
  vpc_endpoint_ssm_id   = ""
  deployment_common_arn = data.terraform_remote_state.kms.outputs.aws_kms_key_id_apne2_deployment_common_arn
  home_sg               = data.terraform_remote_state.vpc.outputs.aws_security_group_home_id

  ssh_key_name                             = var.SSH_KEY_NAME
  tag_first_owner                          = var.tag_first_owner
  tag_second_owner                         = var.tag_second_owner
  ecs_service_role_arn                     = data.terraform_remote_state.iam.outputs.aws_iam_role_ecs_service_role_arn
  aws_iam_instance_profile_ecs_ec2_role_id = data.terraform_remote_state.iam.outputs.aws_iam_instance_profile_ecs_ec2_role_id
  ext_lb_ingress_cidrs                     = ["0.0.0.0/0"]

  lb_variables = var.lb_variables
  sg_variables = var.sg_variables

  repository_url = data.terraform_remote_state.kafka.outputs.ecr_url



}
locals {
  kafka_hosts = [
    for i in range(0, 3) : "kafka${i + 1}.ho-it.me"
  ]
}
locals {
  KAFKA_CONTROLLER_QUORUM_VOTERS = join(",", [for idx in range(3) : format("%d@%s:29093", idx + 1, element(local.kafka_hosts, idx))])
}


# module "kafka-ui" {
#   source          = "../_module/kafka_ui_ecs"
#   service_name    = "kafka-ui"
#   domain_name     = "kafka"
#   tag_project     = "kafka-ui"
#   domain          = "ho-it.me"
#   instance_size   = "t3a.micro"
#   shard_id        = data.terraform_remote_state.vpc.outputs.shard_id
#   public_subnets  = data.terraform_remote_state.vpc.outputs.public_subnets
#   private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
#   account_id      = var.ACCOUNT_ID

#   aws_region                       = data.terraform_remote_state.vpc.outputs.aws_region
#   vpc_cidr_numeral                 = data.terraform_remote_state.vpc.outputs.cidr_numeral
#   route53_internal_domain          = data.terraform_remote_state.vpc.outputs.route53_internal_domain
#   route53_internal_zone_id         = data.terraform_remote_state.vpc.outputs.route53_internal_zone_id
#   target_vpc                       = data.terraform_remote_state.vpc.outputs.vpc_id
#   vpc_name                         = data.terraform_remote_state.vpc.outputs.vpc_name
#   billing_tag                      = data.terraform_remote_state.vpc.outputs.billing_tag
#   acm_external_ssl_certificate_arn = var.r53_variables.ho-it_me_ssl
#   route53_external_zone_id         = var.r53_variables.ho-it_me_zone_id

#   ssm_vpc_endpoint_sg = ""
#   # vpc_endpoint_ssm_id   = data.terraform_remote_state.vpc.outputs.vpc_endpoint_ssm_id
#   vpc_endpoint_ssm_id   = ""
#   deployment_common_arn = data.terraform_remote_state.kms.outputs.aws_kms_key_id_apne2_deployment_common_arn
#   home_sg               = data.terraform_remote_state.vpc.outputs.aws_security_group_home_id

#   ssh_key_name                             = var.SSH_KEY_NAME
#   tag_first_owner                          = var.tag_first_owner
#   tag_second_owner                         = var.tag_second_owner
#   ecs_service_role_arn                     = data.terraform_remote_state.iam.outputs.aws_iam_role_ecs_service_role_arn
#   aws_iam_instance_profile_ecs_ec2_role_id = data.terraform_remote_state.iam.outputs.aws_iam_instance_profile_ecs_ec2_role_id
#   ext_lb_ingress_cidrs                     = ["0.0.0.0/0"]

#   lb_variables = var.lb_variables
#   # sg_variables = var.sg_variables
#   sg_variables = var.sg_variables

#   repository_url                    = data.terraform_remote_state.kafka-ui.outputs.ecr_url
#   KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS = module.kafka.KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS
# }

