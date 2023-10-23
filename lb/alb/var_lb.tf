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
          Name    = "dev_apnortheast2-external-lb"
          app     = "hoit"
          project = "hoit"
          env     = "dev"
          stack   = "dev_apnortheast2"
        },
        # prod = {
        # Name    = "dev_apnortheast2-external-lb"
        #   app     = "api-server"
        #   project = "hoit"
        #   env     = "prod"
        #   stack   = "prod_apnortheast2"
        # },
      }
    }

    external_lb_tg = {
      tags = {
        dev = {
          api = {
            Name    = "api-server-dev_apnortheast2-external-tg"
            app     = "api-server"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          },
          notification = {
            Name    = "notification-dev_apnortheast2-external-tg"
            app     = "notification"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          },
          er_front = {
            Name    = "er-frontend-dev_apnortheast2-external-tg"
            app     = "er-frontend"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          },

          ems_front = {
            Name    = "ems-frontend-dev_apnortheast2-external-tg"
            app     = "ems-frontend"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          },
          jenkins = {
            Name    = "jenkins-dev_apnortheast2-external-tg"
            app     = "jenkins"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          },
          kafka-9092 = {
            Name    = "kafka-9092-dev_apnortheast2-external-tg"
            app     = "kafka-9092"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          },
          kafka-29092 = {
            Name    = "kafka-29092-dev_apnortheast2-external-tg"
            app     = "kafka-29092"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          },
          kafka-29093 = {
            Name    = "kafka-29093-dev_apnortheast2-external-tg"
            app     = "kafka-29093"
            project = "hoit"
            env     = "dev"
            stack   = "dev_apnortheast2"
          }
        },
        # prod = {
        #   Name    = "api-server-prod_apnortheast2-external-tg"
        #   app     = "api-server"
        #   project = "hoit"
        #   env     = "prod"
        #   stack   = "prod_apnortheast2"
        # },
      }
    }
  }
}

variable "ext_lb_ingress_cidrs" {
  default = ["0.0.0.0/0"]
}

variable "domain_name" {
  default = "ho-it.me"
}


variable "kafka_broker_count" {
  default = 1
}

variable "github_hook_sg_ipv4_cidrs" {
  description = ""
  default = [
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",

  ]
}

variable "github_hook_sg_ipv6_cidrs" {
  description = ""
  default = [
    "2a0a:a440::/29",
    "2606:50c0::/32"
  ]
}
