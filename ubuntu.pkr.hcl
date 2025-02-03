packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.0" # Or latest
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name           = "ubuntu-latest-{{timestamp}}" # Naming convention is important
  instance_type      = "t3.micro" # Or your preferred instance type
  region             = "us-east-1"  # Your desired AWS region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-latest-20.04-amd64-server" # Example: Ubuntu 20.04. Adjust as needed
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["063491364108"] # Canonical's owner ID.  Important for verified Ubuntu AMIs
  }

  ssh_username = "ubuntu" # Default username for Ubuntu AMIs

  tags = {
    Name        = "Ubuntu Latest"
    CreatedBy = "Packer"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y amazon-ssm-agent" # Install the SSM agent here
    ]
  }
}