packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ami-nginx-adi" {
    ami_name = "ami-nginx-adi"
    source_ami = "ami-0960ab670c8bb45f3"
    instance_type = "t3a.small"
    region = "us-east-2"
    ssh_username = "ubuntu"
}

build {
    sources = [
        "source.amazon-ebs.ami-nginx-adi"
    ]

    provisioner "shell" {
        script = "./script.sh"
    }

    provisioner "ansible" {
        playbook_file = "./playbook.yml"
    }
}
