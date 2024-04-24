variable "cidr_block" {
  default = "10.0.0.0/24"
}

variable "public_subnets" {
  default = ["10.0.0.0", "10.0.0.127"]
}

variable "private_subnets" {
  default = ["10.0.0.128", "10.0.0.255"]
}

variable "availability_zone" {
  default = ["us-east-1a", "us-east-1b"]
}