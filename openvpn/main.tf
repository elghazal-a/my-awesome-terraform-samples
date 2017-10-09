provider "aws" {
  region = "${var.aws_region}"
}



resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDihlYyUy+yLV7qspj8uYEGBL8mLSvvgAQoM5OXeMJ0J2vVbBs/+oeRQkG/I4cymqOphjtLFMwmGRNtUWg7jQ/6ASLsh4grCS1Zf/hwBtAC0llvHX6zzg8jWeKglET5Ef7fPHJb6VOLepJdotHkYnG00XMMI5tu5fjGi7+eGNAl4GhTzv7aq/SloFRO4vX4N9fzllUKJNL/Sac+qyJzyzo3sNuc5QlxgPwnIeP06pm679yx2uE5pjik2YTSUZe5w5lzYjVlsHYqXAqfd4mWAdnIYNHo+CZDV5MfsA1RSQeBSg7m84sTOl0bzT15+Elye5Xj0HzSPD0JJhmfuD+AAUAJ test@aws"
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_vpn_ports" {
  name        = "allow_vpn_ports"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_vpn_ports"
  }
}

resource "aws_instance" "vpn" {
  ami           = "${data.aws_ami.debian8.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_vpn_ports.id}", "${data.aws_security_group.default_sg.id}"]
  tags {
    Name = "VPN"
    Env = "test"
  }
}
