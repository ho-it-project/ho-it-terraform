
resource "aws_security_group" "hoit_redis" {
  name        = "hoit-redis-${data.terraform_remote_state.vpc.outputs.shard_id}"
  description = "hoit redis security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port = var.port
    to_port   = var.port
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = var.port
    to_port   = var.port
    protocol  = "tcp"
    cidr_blocks = [
      "10.${data.terraform_remote_state.vpc.outputs.cidr_numeral}.0.0/16",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["10.${data.terraform_remote_state.vpc.outputs.cidr_numeral}.0.0/16"]
    description = "Internal redis service port outbound"
  }

  tags = {
    Name    = "dayone-redis-${data.terraform_remote_state.vpc.outputs.vpc_name}-sg"
    project = "dayone"
    role    = "redis"
    stack   = data.terraform_remote_state.vpc.outputs.vpc_name
  }
}
