module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  env = var.env
  private_subnet = var.private_subnet
  public_subnet = var.public_subnet
  azs = var.azs
}
