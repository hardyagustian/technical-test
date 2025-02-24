resource "aws_security_group" "allow-http-s-prod-vpc" {
  name        = "allow http/s access"
  description = "Allow common http/s inbound traffic"
  vpc_id      = aws_vpc.main-prod-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "allow-http-s-prod-vpc"
    Init = "terraform"
  }
}
