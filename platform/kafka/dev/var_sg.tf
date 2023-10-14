variable "sg_variables" {
  default = {

    ecr = {
      tags = {
        dev = {
          Name    = "kafka-dev_apnortheast2-ec2-sg"
          app     = "kafka"
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
          Name    = "kafka-dev_apnortheast2-external-lb-sg"
          app     = "kafka"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
      }
    }

    internal_lb = {
      tags = {
        dev = {
          Name    = "kafka-dev_apnortheast2-internal-lb-sg"
          app     = "kafka"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        }
      }
    }
  }
}


variable "sg_variables-kafka-ui" {
  default = {

    ecr = {
      tags = {
        dev = {
          Name    = "kafka-dev_apnortheast2-ec2-sg"
          app     = "kafka-ui"
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
          Name    = "kafka-dev_apnortheast2-external-lb-sg"
          app     = "kafka-ui"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
      }
    }

    internal_lb = {
      tags = {
        dev = {
          Name    = "kafka-dev_apnortheast2-internal-lb-sg"
          app     = "kafka-ui"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        }
      }
    }
  }
}
