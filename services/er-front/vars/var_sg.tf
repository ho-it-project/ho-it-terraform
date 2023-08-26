variable "sg_variables" {
  default = {

    ecr = {
      tags = {
        dev = {
          Name    = "er-front-dev_apnortheast2-ec2-sg"
          app     = "er-front"
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
          Name    = "er-front-dev_apnortheast2-external-lb-sg"
          app     = "er-front"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
      }
    }
  }
}
