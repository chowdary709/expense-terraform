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
  type        = map(string)
  project     = "roboshop"
  environment = "dev"
}

variable "project_name" {
  default = "roboshop"
}
variable "env" {
  default = "dev"
}