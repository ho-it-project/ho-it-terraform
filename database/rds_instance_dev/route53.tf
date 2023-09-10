resource "aws_route53_record" "rds_postgresql" {
  zone_id = data.terraform_remote_state.route53.outputs.ho-it_me_zone_id
  name    = "rds-postgresql.${data.terraform_remote_state.route53.outputs.ho-it_me_zone_name}"
  type    = "CNAME"
  ttl     = "300"
  records = [
    aws_db_instance.rds_postgresql.address,
  ]
}


