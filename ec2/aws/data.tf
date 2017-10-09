data "aws_ami" "debian8" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-jessie*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["379101102735"] # Debian
}

data "aws_ami" "ubuntu16" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*16.04*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Canonical
}


data "aws_security_group" "default_sg" {
  name = "default"
}