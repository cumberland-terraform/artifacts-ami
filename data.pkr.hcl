data "amazon-ami" "ami" {
    filters                     = {
        virtualization-type     = var.ami.virtualization_type
        name                    = var.ami.name
        root-device-type        = var.ami.root_device_type
    }
    owners                      = [ var.aws.account_id ]
    most_recent                 = true
}