env = "dev"

vpc_cidr               = "10.0.0.0/16"
public_subnets         = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets        = ["10.0.2.0/24", "10.0.3.0/24"]
azs                    = ["us-east-1a", "us-east-1b"]
default_vpc_id         = "vpc-0468c874d427a36de"
default_vpc_cidr       = "172.31.0.0/16"
default_route_table_id = "rtb-005398010e7bea680"
account_no             = "666171310914"
bastion_node_cidr      = ["172.31.33.156/32"]
