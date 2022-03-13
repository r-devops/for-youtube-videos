resource "aws_security_group" "allow-all-main-vpc" {
  name        = "allow-all-main-vpc"
  description = "allow-all-main-vpc"
  vpc_id      = aws_vpc.public.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all-main-vpc"
  }
}

resource "aws_security_group" "allow-all-vpc1" {
  name        = "allow-all-vpc1"
  description = "allow-all-vpc1"
  vpc_id      = aws_vpc.vpc1-private.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name ="allow-all-vpc1"
  }
}

resource "aws_security_group" "allow-all-vpc2" {
  name        = "allow-all-vpc2"
  description = "allow-all-vpc2"
  vpc_id      = aws_vpc.vpc2-private.id

  ingress {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      description      = "egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name ="allow-all-vpc2"
  }
}