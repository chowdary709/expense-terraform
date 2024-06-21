resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "public-subnets-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_subnets[count.index]

  tags = {
    Name = "private-subnets-${count.index + 1}"
  }
}

resource "aws_subnet" "database" {
  count             = length(var.database_subnets)
  vpc_id            = aws_vpc.main.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.database_subnets[count.index]

  tags = {
    Name = "database-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# resource "aws_eip" "eip" {
#   domain   = "vpc"
#   tags = {
#     Name = "${var.env}-eip"
#   }
# }
#
# resource "aws_nat_gateway" "ngw" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public_subnets.id
#
#   tags = {
#     Name = "${var.env}-ngw"
#   }
# }

resource "aws_vpc_peering_connection" "peering_connection" {
  peer_vpc_id = data.aws_vpc.default.id
  vpc_id      = aws_vpc.main.id
  auto_accept = true
  tags = {
    Name = "peering-from default-vpc-to-${var.env}-vpc"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.ngw.id
#   }

  route {
    cidr_block = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }

  tags = {
    Name = "${var.env}-private-route-table"
  }
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.ngw.id
#   }
  route {
    cidr_block = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }
  tags = {
    Name = "${var.env}-database-route-table"
  }
}