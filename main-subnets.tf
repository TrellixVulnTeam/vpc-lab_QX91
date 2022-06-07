resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "walter"
  }
}

resource aws_security_group https_ingress {
  name   = "walter-https"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port        = 80
    protocol         = "tcp"
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    protocol         = "tcp"
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}