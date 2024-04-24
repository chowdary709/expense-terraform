resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "public-${count.index + 1 }"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "private-${count.index + 1 }"
  }
}