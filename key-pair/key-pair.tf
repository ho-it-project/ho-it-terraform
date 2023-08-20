resource "aws_key_pair" "hoit_master" {
  key_name   = "hoit_master"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
  lifecycle {
    ignore_changes = [public_key]
  }
}
