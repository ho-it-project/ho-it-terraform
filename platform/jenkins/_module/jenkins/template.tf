data "template_file" "init" {
  template = file("${path.module}/scripts/userdata.sh")
  vars = {
    efs_dns_name   = aws_efs_file_system.file_system.dns_name
    aws_account_id = var.account_id
  }
}

