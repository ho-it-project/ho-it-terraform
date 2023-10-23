# Atlantis user

# Account IDs
# Add all account ID to here 
variable "account_id" {
  type = map(string)
  default = {
    dev = ""
  }
}

variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "EC2_TYPE" {
  type = map(string)
  default = {
    "t2micro" = "t2.micro"
    "t3micro" = "t3.micro"
    "t2small" = "t2.small"
  }
}


variable "AWS_AMI_LIST" {
  type = map(string)
  default = {
    "ubuntu_20_04_x86" = "ami-04341a215040f91bb"
    "ubuntu_20_04_arm" = "ami-0ac62099928d25fec"
    "ubuntu_22_04_x86" = "ami-0c9c942bd7bf113a2"
    "ubuntu_22_04_arm" = "ami-00fdfe418c69b624a"
  }
}

# Remote State that will be used when creating other resources
# You can add any resource here, if you want to refer from others
variable "remote_state" {
  default = {
    # VPC
    vpc = {
      dev = {
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/vpc/hoit-dev/terraform.tfstate"
        region = "ap-northeast-2"
      }
    }

    # WAF ACL
    waf_web_acl_global = {
      prod = {
        region = ""
        bucket = ""
        key    = ""
      }
    }

    # AWS IAM
    iam = {

      id = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/iam/hoit-id/terraform.tfstate"
      }
    }


    kms = {
      dev = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/kms/hoit-id/terraform.tfstate"
      }
    }


    # ECR
    ecr = {
      api_server = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/ecr/hoit/api-server/terraform.tfstate"
      },
      notification_server = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/ecr/hoit/notification-server/terraform.tfstate"
      },
      er_front = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/ecr/hoit/er-front/terraform.tfstate"
      },
      ems_front = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/ecr/hoit/ems-front/terraform.tfstate"
      },
      kafka = {
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/ecr/hoit/kafka/terraform.tfstate"
        region = "ap-northeast-2"
      },
      kafka-ui = {
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/ecr/hoit/kafka-ui/terraform.tfstate"
        region = "ap-northeast-2"
      }

    }

    route53 = {
      ho-it_me = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/route53/hoit/ho-it.me/terraform.tfstate"
      }

    }

    lb = {
      dev = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/lb/alb/dev/terraform.tfstate"
      }
    }

    nlb = {
      dev = {
        region = "ap-northeast-2"
        bucket = "hoit-apnortheast2-tfstate"
        key    = "hoit/terraform/lb/nlb/dev/terraform.tfstate"
      }
    }

  }
}



variable "PATH_TO_PRIVATE_KEY" {
  default = "./hoit_master"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "./hoit_master.pub"
}

variable "SSH_KEY_NAME" {
  default = "hoit_master"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
