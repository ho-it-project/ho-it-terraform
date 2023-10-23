variable "sg_variables" {
  default = {

    ecr = {
      tags = {
        dev = {
          Name    = "alb-dev_apnortheast2-ec2-sg"
          app     = "alb"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
        #prod 추가
      }
    }

    external_lb = {
      tags = {
        dev = {
          Name    = "alb-dev_apnortheast2-external-lb-sg"
          app     = "alb"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
      }
    }
  }
}


variable "home_sg" {
  description = "Office people IP list."
  default     = ""
}
