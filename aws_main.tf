terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# Defining Master count


provider "aws" {
  access_key=var.access_key
  secret_key=var.secret_key
  region      = var.region
}

resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = "ec2_via_terraform2"
  tags = {
    Name = var.tag
  }
  vpc_security_group_ids = [aws_security_group.main.id]

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      # private_key = file("/home/ec2-user/.ssh/id_rsa")
      private_key = file("/home/karthik/terraform/aws/ssh/id_rsa.ppk")
      timeout     = "4m"
   }
}

output "ec2_public_ip" {
  value = aws_instance.app_server.public_ip
}

resource "aws_key_pair" "deployer" {
  key_name   = "ec2_via_terraform2"
  public_key = var.ssh-public-key
}

resource "aws_security_group" "main" {
    name = "main-sg3-km"
    ingress {
        cidr_blocks = [
        "0.0.0.0/0"
        ]
    from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    // Terraform removes the default rule
    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}
