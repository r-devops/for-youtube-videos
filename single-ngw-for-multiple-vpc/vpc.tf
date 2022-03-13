## Public VPC
resource "aws_vpc" "public" {
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "public-vpc"
  }
}

## VPC1 Private
resource "aws_vpc" "vpc1-private" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc1-private"
  }
}

## VPC2 Private
resource "aws_vpc" "vpc2-private" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "vpc2-private"
  }
}
