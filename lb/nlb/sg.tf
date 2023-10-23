
###### kafka sg  
## 개발편의상 private x 
resource "aws_security_group" "kafka" {
  name        = "kraft-kafka-${data.terraform_remote_state.vpc.outputs.vpc_name}"
  description = "Kraft Kafka Broker Security Group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # INTERNAL Listener
  ingress {
    from_port   = 29092
    to_port     = 29092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Kafka INTERNAL Listener"
  }

  # CONTROLLER Listener
  ingress {
    from_port   = 29093
    to_port     = 29093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Kafka CONTROLLER Listener"
  }

  # EXTERNAL Listener
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Kafka EXTERNAL Listener"
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound Traffic"
  }

  tags = {
    Name  = "kraft-kafka-${data.terraform_remote_state.vpc.outputs.vpc_name}-sg"
    stack = data.terraform_remote_state.vpc.outputs.vpc_name
  }
}






