provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "ap-web-01" {
  key_name   = "ap-web-01"
  public_key = "YOUR_SSH_PUB_KEY"
}

resource "aws_instance" "ap-web-01" {
  ami = "ami-086c142842468ba9d"
  instance_type = "t4g.micro"
  key_name = "ap-web-01"
  security_groups = ["ap-web-01"]
  user_data = "${file("userdata.sh")}"

  tags = {
    Name = "ap-web-01"
    env = "prod"
    owner = "admin"
  }

}

resource "aws_security_group" "ap-web-01" {
  name        = "ap-web-01"
  description = "ap-web-01 inbound traffic"

  ingress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ap-web-01"
  }
}