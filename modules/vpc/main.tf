resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    name: "${var.env}-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    name = "public-subnet- ${count.index}",
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    name = "private-subnet- ${count.index}",
  }
}
