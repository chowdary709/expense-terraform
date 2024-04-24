resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  tags = {
    Name = "vpc"
  }
}


#resource "aws_subnet" "public_subnets" {
#  count             = length(var.public_subnets)
#  vpc_id            = aws_vpc.main.id
#  cidr_block        = var.public_subnets[count.index]
#  availability_zone = var.azs[count.index]
#  tags = {
#    Name = "public-subnet-${count.index + 1}"
#  }
#}
#
#// Define private subnets
#resource "aws_subnet" "private_subnets" {
#  count             = length(var.private_subnets)
#  vpc_id            = aws_vpc.main.id
#  cidr_block        = var.private_subnets[count.index]
#  availability_zone = var.azs[count.index]
#  tags = {
#    Name = "private-subnet-${count.index + 1}"
#  }
#}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

// Define private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}