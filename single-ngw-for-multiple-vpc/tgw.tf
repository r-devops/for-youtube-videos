resource "aws_ec2_transit_gateway" "tgw" {
  description = "igw"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
}

resource "aws_ec2_transit_gateway_route_table" "public-vpc" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_ec2_transit_gateway_route_table" "vpc1-n-vpc2" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}


resource "aws_ec2_transit_gateway_vpc_attachment" "main-private-subnet" {
  subnet_ids         = [aws_subnet.main-private-subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.public.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1-private-subnet" {
  subnet_ids         = [aws_subnet.vpc1-private-subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc1-private.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2-private-subnet" {
  subnet_ids         = [aws_subnet.vpc2-private-subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc2-private.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}

resource "aws_ec2_transit_gateway_route_table_association" "public-vpc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main-private-subnet.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.public-vpc.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc1-private-subnet" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc1-private-subnet.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc1-n-vpc2.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc2-private-subnet" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc2-private-subnet.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc1-n-vpc2.id
}

resource "aws_ec2_transit_gateway_route" "vpc1-n-vpc2" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main-private-subnet.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc1-n-vpc2.id
}

resource "aws_ec2_transit_gateway_route" "public-to-vpc-1" {
  destination_cidr_block         = "10.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc1-private-subnet.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.public-vpc.id
}

resource "aws_ec2_transit_gateway_route" "public-to-vpc-2" {
  destination_cidr_block         = "10.1.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc2-private-subnet.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.public-vpc.id
}
