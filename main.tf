provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name    = "Task 6.12"
    Company = "Innowise"
    Owner   = "Misyuro Nikita"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  availability_zone = var.azs[0]
  cidr_block        = var.public_subnet_1_cidrs

  tags = {
    Name = "First public Subnet"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  availability_zone = var.azs[1]
  cidr_block        = var.public_subnet_2_cidrs

  tags = {
    Name = "Second public Subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "Internet Gateway"
    Owner       = "Misyuro Nikita"
    Description = "Access to the Internet"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd Route Table"
  }
}

resource "aws_route_table_association" "route_subnet1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "route_subnet2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rt.id
}
