resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
      Name = "${var.project_name}-${var.env}" // local.Name
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
      Name = local.Name
    }
  )
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.public_subnet_tags,
    {
      Name = "${local.Name}-public-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.private_subnet_tags,
    {
      Name = "${local.Name}-private-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "database" {
  count             = length(var.database_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.database_subnet_tags,
    {
      Name = "${local.Name}-database-${local.az_names[count.index]}"
    }
  )
}

# resource "aws_eip" "eip" {
#   domain = "vpc"
# }
#
# resource "aws_nat_gateway" "ngw" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public[0].id
#
#   tags = merge(
#     var.common_tags,
#     var.ngw_tags,
#     {
#       Name = "${local.Name}-ngw"
#     }
#   )
# }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id


  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
      Name = "${local.Name}-public"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.private_route_table_tags,
    {
      Name = "${local.Name}-private"
    }
  )
}


resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id


  tags = merge(
    var.common_tags,
    var.database_route_table_tags,
    {
      Name = "${local.Name}-database"
    }
  )
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
#
# resource "aws_route" "private" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.ngw.id
# }
#
# resource "aws_route" "database" {
#   route_table_id         = aws_route_table.database.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.ngw.id
# }


resource "aws_route_table_association" "public" {
  count                  = length(var.public_subnet_cidr)  // ["10.0.0.0/24", "10.0.1.0/24"]
  subnet_id              = element(aws_subnet.public[*].id, count.index)
  route_table_id         = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count                  = length(var.private_subnet_cidr)
  subnet_id              = element(aws_subnet.private[*].id, count.index)
  route_table_id         = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count                  = length(var.database_subnet_cidr)
  subnet_id              = element(aws_subnet.database[*].id, count.index)
  route_table_id         = aws_route_table.database.id
}

resource "aws_vpc_peering_connection" "peering_connection" {
  count = var.is_peering_required ? 1 : 0
  vpc_id      = aws_vpc.main.id
  peer_vpc_id = var.acceptor_vpc_id == "" ? data.aws_vpc.default.id : var.acceptor_vpc_id
  auto_accept = var.acceptor_vpc_id == "" ? true : false

  tags = merge(
    var.common_tags
    var.vpc_peering_tags
    {
      Name = "peering-from-default-vpc-to-${local.Name}"
    }
  )
}

