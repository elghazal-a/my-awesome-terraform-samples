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

resource "aws_security_group" "allow_other_ports" {
  name        = "allow_other_ports"
  description = "Allow web,.. inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_web_ports"
  }
}

resource "aws_instance" "ec2" {
  ami           = "${data.aws_ami.ubuntu16.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_other_ports.id}", "${data.aws_security_group.default_sg.id}"]
  tags {
    Name = "test"
  }
}
