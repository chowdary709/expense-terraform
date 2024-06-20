locals {
  Name = "${var.project_name}-${var.env}"
  az_names = slice(data.aws_availability_zones.azs.names,0,2)
}
