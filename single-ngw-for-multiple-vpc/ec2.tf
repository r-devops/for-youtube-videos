data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-7-DevOps-Practice"
  owners      = ["973714476881"]
}

resource "aws_instance" "public" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-all-main-vpc.id]
  subnet_id = aws_subnet.main-public-subnet.id
  associate_public_ip_address = true
}

resource "aws_instance" "vpc1" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-all-vpc1.id]
  subnet_id = aws_subnet.vpc1-private-subnet.id
}

resource "aws_instance" "vpc2" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-all-vpc2.id]
  subnet_id = aws_subnet.vpc2-private-subnet.id
}
