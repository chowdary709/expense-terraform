resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

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
    var.common_tags
    var.igw_tags
    {
      Name = local.Name
    }
  )
}