variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "common_tags" {
  type = map(string)
  default = {
    project     = "roboshop"
    terraform   = "true"
    environment = "dev"
  }
}
variable "vpc_tags" {
  type = map(string)
  default = {
    project     = "roboshop"
    environment = "dev"
  }
}

variable "project_name" {
  default = "roboshop"
}
variable "env" {
  default = "dev"
}

variable "igw_tags" {
  type = map
  default = {}
}

variable "public_subnet_cidr" {
  type = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
  validation {
    condition     = length(var.public_subnet_cidr) == 2
    error_message = "please provide exactly 2 valid  subnet CIDRs"
  }
}

variable "private_subnet_cidr" {
  type = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
  validation {
    condition     = length(var.private_subnet_cidr) == 2
    error_message = "please provide exactly 2 valid  subnet CIDRs"
  }
}

variable "public_subnet_tags" {
  default = {}
}