source "amazon-ebs" "ami" {
  ami_name                    = local.name
  encrypt_boot                = local.platform_defaults.encrypt_boot
  instance_type               = var.ami.instance_type
  kms_key_id                  = var.kms
  region                      = var.aws.region
  source_ami                  = data.amazon-ami.ami.id
  ssh_username                = local.platform_defaults.username
  subnet_id                   = var.aws.subnet_id
  tags                        = local.tags
  vpc_id                      = var.aws.vpc_id
}

build {
  sources                     = ["source.amazon-ebs.ami"]

  provisioner "shell" {
    script                    = local.conditions.is_linux ? (
                                local.scripts.linux
                              ) : local.scripts.windows
  }
}