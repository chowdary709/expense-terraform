data "aws_availability_zones" "azs" {
  #all_availability_zones = true
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}