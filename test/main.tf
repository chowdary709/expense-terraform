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

# module "public-lb" {
#   source            = "./modules/alb"
#   alb_sg_allow_cidr = "0.0.0.0/0"
#   alb_type          = "public"
#   env               = var.env
#   internal          = false
#   subnets           = module.vpc.public_subnet
#   vpc_id            = module.vpc.vpc_id
# }
#
# module "private-lb" {
#   source            = "./modules/alb"
#   alb_sg_allow_cidr = "0.0.0.0/0"
#   alb_type          = "private"
#   env               = var.env
#   internal          = false
#   subnets           = module.vpc.private_subnet
#   vpc_id            = module.vpc.vpc_id
# }

module "frontend" {
  source        = "./modules/app"
  component     = "frontend"
  env           = var.env
  instance_type = "t2.micro"
  port          = "80"
  subnets       = module.vpc.private_subnet
  vpc_cidr      = var.vpc_cidr
  vpc_id        = module.vpc.vpc_id
  bastion_node_cidr = var.bastion_node_cidr
}
