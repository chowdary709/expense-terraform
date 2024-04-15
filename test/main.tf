module "frontend" {
  source        = "./module/app"
  app_port      = 80
  component     = "frontend"
  instance_type = "t2.micro"
  subnets       = ["subnet-0233174d26bc6112d"]  # Subnets should be provided as a list
  vpc_id        = "vpc-0d36408476c035854"
}
