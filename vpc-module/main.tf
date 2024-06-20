module "vpc" {
  source = "./module/vpc"
  common_tags  = var.common_tags
  env          = var.env
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  vpc_tags     = var.vpc_tags
  igw_tags     = var.igw_tags
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_tags = var.public_subnet_tags
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_tags = var.private_subnet_tags
}