variable "lb_variables" {
  default = {

    target_group_slow_start = {
      dev = 0
      #   prod = 0
    }

    target_group_deregistration_delay = {
      dev = 60
      #   prod = 60
    }

    external_lb = {
      tags = {
        dev = {
          Name    = "kafka-dev_apnortheast2-external-lb"
          app     = "kafka"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
        # prod = {
        #   Name    = "kafka-prod_apnortheast2-external-lb"
        #   app     = "kafka"
        #   project = "hoit"
        #   env     = "prod"
        #   stack   = "prod_apnortheast2"
        # },
      }
    }
    internal_lb = {
      tags = {
        dev = {
          Name    = "kafka-dev_apnortheast2-internal-lb"
          app     = "kafka"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
      }
    }

    external_lb_tg = {
      tags = {
        dev = {
          Name = "kafka-dev_apnortheast2-external-tg"
          app  = "kafka"

          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
        # prod = {
        #   Name    = "kafka-prod_apnortheast2-external-tg"
        #   app     = "kafka"
        #   project = "hoit"
        #   env     = "prod"
        #   stack   = "prod_apnortheast2"
        # },
      }
    }
    internal_lb_tg = {
      tags = {
        dev = {
          Name = "kafka-dev_apnortheast2-internal-tg"
          app  = "kafka"

          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },

      }
    }
  }
}
