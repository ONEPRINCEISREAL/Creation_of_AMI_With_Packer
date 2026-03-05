packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name                    = var.ami_name
  instance_type               = var.instance_type
  region                      = var.region
  subnet_id                   = "subnet-0fdcf744ca22434a0"
  associate_public_ip_address = true

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = var.ssh_username
}

build {
  name    = "learn-packer"
  sources = ["source.amazon-ebs.ubuntu"]

provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx"
    ]
  }
  }