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
          Name    = "er-front-dev_apnortheast2-external-lb"
          app     = "er-front"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
        # prod = {
        #   Name    = "er-front-prod_apnortheast2-external-lb"
        #   app     = "er-front"
        #   project = "hoit"
        #   env     = "prod"
        #   stack   = "prod_apnortheast2"
        # },
      }
    }

    external_lb_tg = {
      tags = {
        dev = {
          Name    = "er-front-dev_apnortheast2-external-tg"
          app     = "er-front"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
        # prod = {
        #   Name    = "er-front-prod_apnortheast2-external-tg"
        #   app     = "er-front"
        #   project = "hoit"
        #   env     = "prod"
        #   stack   = "prod_apnortheast2"
        # },
      }
    }
  }
}
