resource "aws_route53_zone" "ho-it_me" {
  name    = "ho-it.me"
  comment = "HostedZone created by Route53 Registrar - Manged Terraform"
}

output "name_servers" {
  value = aws_route53_zone.ho-it_me.name_servers
}

output "ho-it_me_zone_id" {
  value = aws_route53_zone.ho-it_me.zone_id
}
output "ho-it_me_zone_name" {
  value = aws_route53_zone.ho-it_me.name
}
