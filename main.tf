provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "Task 6.12"
    Company = "Innowise"
    Owner   = "Misyuro Nikita"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.public_subnet_1_cidrs)
  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.public_subnet_1_cidrs, count.index)

  tags = {
    Name = "First public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.public_subnet_2_cidrs)
  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.public_subnet_2_cidrs, count.index)

  tags = {
    Name = "Second public subnet ${count.index + 1}"
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

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd Route Table"
  }
}
