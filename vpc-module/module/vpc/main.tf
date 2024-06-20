resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
      Name = "${var.project_name}-${var.env}"
    }
  )
}
