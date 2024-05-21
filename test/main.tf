module "vpc" {
  source           = "./modules/vpc"
  account_no       = var.account_no
  azs              = var.azs
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_id   = var.default_vpc_id
  env              = var.env
  private_subnet   = var.private_subnet
  public_subnet    = var.public_subnet
  route_table_id   = var.route_table_id
  vpc_cidr         = var.vpc_cidr
}