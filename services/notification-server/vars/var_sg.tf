variable "sg_variables" {
  default = {

    ecr = {
      tags = {
        dev = {
          Name    = "api-server-dev_apnortheast2-ec2-sg"
          app     = "api-server"
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
          Name    = "api-server-dev_apnortheast2-external-lb-sg"
          app     = "api-server"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
      }
    }
  }
}
