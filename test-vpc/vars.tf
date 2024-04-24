variable "cidr_block" {
  default = "10.0.0.0/16"
}

#variable "public_subnets" {
#  default = ["10.0.0.0/24", "10.0.1.0/24"]
#}
#
#variable "private_subnets" {
#  default = ["10.0.2.0/24", "10.0.3.0/24"]
#}

variable "public_subnets" {
  default = ["10.0.0.0/24"]
}

variable "private_subnets" {
  default = ["10.0.1.0/24"]
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "account_no" {
  default = "666171310914"
}
variable "default_vpc_id" {
  default = "vpc-0d36408476c035854"
}
