variable "cidr_block" {
  default = "10.0.0.0/24"
}

variable "public_subnets" {
  default = ["10.0.0.0/25"]
}

variable "private_subnets" {
  default = ["10.0.0.128/25"]
}

variable "availability_zone" {
  default = ["us-east-1a", "us-east-1b"]
}