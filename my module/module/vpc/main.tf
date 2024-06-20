resource "aws_vpc" "main" {
  cidr_block = "var.vpc_cidr"
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  availability_zone = ""
  cidr_block = ""
}