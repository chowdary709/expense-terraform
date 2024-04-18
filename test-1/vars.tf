variable "instance_name" {
  default = ["frontend","mysql","backend"]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "Zone_id" {
  default = "Z08360431XA1BOY4SK2N0"
}

variable "sg" {
  default = ["sg-0b792d7d432d8d378"]
}



variable "us-east-1a" {
  default = "subnet-0804bbb270a178237"
}

variable "us-east-1b" {
  default = "subnet-017ad3134d13bee7a"
}

variable "us-east-1c" {
  default = "subnet-0233174d26bc6112d"
}

variable "us-east-1d" {
  default = "subnet-0a0921662d2e5c383"
}
variable "us-east-1e" {
  default = "subnet-0247672ece18e6e2d"
}

variable "us-east-1f" {
  default = "subnet-0a0e628511903cfb1"
}