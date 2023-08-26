resource "aws_route53_zone" "ho-it_com" {
  name    = "ho-it.com"
  comment = "HostedZone created by Route53 Registrar - Manged Terraform"
}

output "name_servers" {
  value = aws_route53_zone.ho-it_com.name_servers
}


