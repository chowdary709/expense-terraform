module "vpc" {
  source         = "./module/vpc"
  env            = var.env
  vpc_cidr       = var.vpc_cidr
  azs            = var.azs
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
}