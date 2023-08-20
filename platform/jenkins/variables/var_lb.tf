variable "lb_variables" {
  default = {

    target_group_slow_start = {
      dev = 0
    }

    target_group_deregistration_delay = {
      dev = 60
    }

    external_lb = {
      tags = {
        dev = {
          Name    = "jenkins-dev-external-lb"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dev_apnortheast2"
        }
      }
    }

    external_lb_tg = {
      tags = {
        dev = {
          Name    = "jenkins-dev_apnortheast2-external-tg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dev_apnortheast2"
        }
      }
    }
  }
}
