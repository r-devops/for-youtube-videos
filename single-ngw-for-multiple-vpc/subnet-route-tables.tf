resource "aws_route_table" "main-public-rt" {
  vpc_id = aws_vpc.public.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-public-rt"
  }
}


resource "aws_route_table" "main-private-rt" {
  vpc_id = aws_vpc.public.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "main-private-rt"
  }
}

resource "aws_route_table_association" "to-public-rt" {
  subnet_id      = aws_subnet.main-public-subnet.id
  route_table_id = aws_route_table.main-public-rt.id
}

resource "aws_route_table_association" "to-private-rt" {
  subnet_id      = aws_subnet.main-private-subnet.id
  route_table_id = aws_route_table.main-private-rt.id
}

resource "aws_route_table" "vpc1-private-rt" {
  vpc_id = aws_vpc.vpc1-private.id

  tags = {
    Name = "vpc1-private-rt"
  }
}

resource "aws_route_table" "vpc2-private-rt" {
  vpc_id = aws_vpc.vpc2-private.id

  tags = {
    Name = "vpc2-private-rt"
  }
}

resource "aws_route" "route-to-vpc1" {
  route_table_id            = aws_route_table.vpc1-private-rt.id
  destination_cidr_block    = "0.0.0.0/0"
  transit_gateway_id        = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "route-to-vpc2" {
  route_table_id            = aws_route_table.vpc2-private-rt.id
  destination_cidr_block    = "0.0.0.0/0"
  transit_gateway_id        = aws_ec2_transit_gateway.tgw.id
}


resource "aws_route_table_association" "vpc1" {
  subnet_id      = aws_subnet.vpc1-private-subnet.id
  route_table_id = aws_route_table.vpc1-private-rt.id
}

resource "aws_route_table_association" "vpc2" {
  subnet_id      = aws_subnet.vpc2-private-subnet.id
  route_table_id = aws_route_table.vpc2-private-rt.id
}


resource "aws_route" "main-public-subnet-route-to-vpc1" {
  route_table_id            = aws_route_table.main-public-rt.id
  destination_cidr_block    = "10.0.0.0/16"
  transit_gateway_id        = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "main-public-subnet-route-to-vpc2" {
  route_table_id            = aws_route_table.main-public-rt.id
  destination_cidr_block    = "10.1.0.0/16"
  transit_gateway_id        = aws_ec2_transit_gateway.tgw.id
}
