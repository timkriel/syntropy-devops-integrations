resource "aws_vpc" "syntropy" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "syntropy-public" {
  vpc_id     = aws_vpc.syntropy.id
  cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  count = 1
}

resource "aws_subnet" "syntropy-private" {
  vpc_id     = aws_vpc.syntropy.id
  cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index+3)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  count = 2
  tags = {
    "kubernetes.io/cluster/syntropy" = "shared"
  }
}

resource "aws_eip" "syntropy-nat-gateway" {
  vpc = true
}

resource "aws_nat_gateway" "syntropy" {
  allocation_id = aws_eip.syntopy-nat-gateway.id
  subnet_id     = aws_subnet.syntropy-public.0.id
}

resource "aws_internet_gateway" "syntropy" {
  vpc_id = aws_vpc.syntropy.id
}

resource "aws_default_security_group" "syntropy-default" {
  vpc_id = aws_vpc.syntopy.id

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [aws_vpc.syntopy.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_default_route_table" "syntropy-public" {
  default_route_table_id = aws_vpc.syntropy.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.syntropy.id
  }
}

resource "aws_default_route_table" "syntropy-private" {
  vpc_id = aws_vpc.syntropy.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.syntropy.id
  }
}

resource "aws_route_table_association" "syntropy-public-0" {
  subnet_id      = aws_subnet.syntropy-public.0.id
  route_table_id = aws_route_table.bar.id
}

resource "aws_route_table_association" "syntropy-private-0" {
  subnet_id      = aws_subnet.syntropy-private.0.id
  route_table_id = aws_route_table.bar.id
}

resource "aws_route_table_association" "syntropy-private-1" {
  subnet_id      = aws_subnet.syntropy-private.1.id
  route_table_id = aws_route_table.bar.id
}