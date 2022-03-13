// Public VPC Subnets
resource "aws_subnet" "main-public-subnet" {
  cidr_block = "192.168.0.0/25"
  vpc_id = aws_vpc.public.id
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "main-private-subnet" {
  cidr_block = "192.168.0.128/25"
  vpc_id = aws_vpc.public.id
  tags = {
    Name = "private-subnet"
  }
}

// VPC1 Private Subnets
resource "aws_subnet" "vpc1-private-subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.vpc1-private.id
  tags = {
    Name = "vpc1-private-subnet"
  }
}

// VPC2 Private Subnets
resource "aws_subnet" "vpc2-private-subnet" {
  cidr_block = "10.1.0.0/24"
  vpc_id = aws_vpc.vpc2-private.id
  tags = {
    Name = "vpc2-private-subnet"
  }
}
