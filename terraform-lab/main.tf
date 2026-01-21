locals {
  tag_Name = "user3-${var.env}"
}

provider "aws" {
    region = var.region
    default_tags {
       tags = {
          owner = "user3"
       }
    }
}

resource "aws_instance" "main" {
  ami = var.ami_id
  instance_type = var.instance_type
  count = var.num_of_vm
  #ami = data.aws_ami.amazon_linux_2023.id
  #instance_type = "t3.micro"
  #count = 1

  tags = {
    "Name" = local.tag_Name
    #"Name" = "user3"
  }
}

/*
resource "aws_instance" "main" {
    ami = "ami-0ced6a024bb18ff2e"
    instance_type = "t2.micro"
    tags = {
      Name = "user3"
    }
}
*/

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "vm_ip" {
  value = aws_instance.main[0].public_ip
}

output "vm_ips" {
  value = [ for vm in aws_instance.main : vm.public_ip ]
}