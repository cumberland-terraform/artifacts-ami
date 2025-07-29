variable "platform" {
  description                     = "Platform metadata configuration object."
  type                            = object({
    client                        = string 
    environment                   = string
  })
}

variable "aws" {
    description                 = "AWS metadata configuration object."
    type                        = object({
        account_id              = string
        region                  = string
        subnet_id               = string
        vpc_id                  = string
    })
    default                     = {
        account_id              = env("AWS_ACCOUNT_ID")
        region                  = env("AWS_REGION")
        subnet_id               = env("BUILD_SUBNET_ID")
        vpc_id                  = env("BUILD_VPC_ID")
    }
}

variable "ami" {
    description                 = "AMI configuration object."
    type                        = object({
        name                    = string
        instance_type           = string
        root_device_type        = string
        virtualization_type     = string
    })
    default                     = {
        name                    = "ubuntu.images/hvm-ssd/ubuntu-jammay-22.04-arm64-server*"
        instance_type           = "t4g.nano"
        root_device_type        = "ebs"
        virtualization_type     = "hvm"
    }
}

variable "kms" {
    description                 = "KMS ID, ARN or Alias for encrypting block devices."
    type                        = string
    default                     = null
}