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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}


resource "aws_vpc_peering_connection" "peering" {
  peer_owner_id = var.account_no
  peer_vpc_id   = var.default_vpc_id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true
  tags = {
    Name = "peering-from-default-vpc-to--vpc"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.igw.id
#  }

  tags = {
    Name = "private"
  }
}