variable "sg_variables" {
  default = {

    ec2 = {
      tags = {
        dev = {
          Name    = "jenkins-dev_apnortheast2-ec2-sg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dev_apnortheast2"
        }
      }
    }

    external_lb = {
      tags = {
        dev = {
          Name    = "jenkins-dev_apnortheast2-external-lb-sg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dev_apnortheast2"
        }
      }
    }
  }
}
