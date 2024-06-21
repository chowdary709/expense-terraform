```hcl 

resource "aws_route_table_association" "public" {
  count                  = length(var.public_subnet_cidr)  // ["10.0.0.0/24", "10.0.1.0/24"]
  subnet_id              = element(aws_subnet.public[*].id, count.index)
  route_table_id         = aws_route_table.public.id
}


 subnet_id              = element(aws_subnet.public[*].id, count.index) 
 
    // hear element(list, index) [*].id -> men access all elements ids , count.index is loop 
    
     element retrieves a single element from a list.
```
```bash
terraform init -backend-config="env-dev/state.tfvats"
terraform apply -auto-approve -var-file="env-dev/terraform.tfvars"
terraform destroy -auto-approve -var-file="env-dev/terraform.tfvars"
```

```
├──   ^ └── ^  │  ^  │   │   ├── ^ 

│   │   ├── 
│   │   ├── 
│   │   └── 
```
```
VPC Setup Flowchart:

1. VPC CIDR
   ├── Subnets {3}
   │   ├── Public
   │   ├── Private
   │   └── Database
   ├── Availability Zones {2}
   │   ├── us-east-1a
   │   └── us-east-1b
   ├── Internet Gateway
   ├── EIP
   ├── NAT Gateway
   ├── VPC Peering
   ├── Route Tables {3}
   │   ├── Public
   │   │   └── Attach IGW [0.0.0.0/0 igw]
   │   ├── Private
   │   │   └── Attach NGW
   │   │       ├── Add Routes [0.0.0.0/0 ngw]
   │   │       └── Default VPC CIDR, VPC Peering Connection 
   │   └── Database
   │       └── Attach NGW
   │           ├── Add Routes [0.0.0.0/0 ngw]
   │           └── Default VPC CIDR, VPC Peering Connection
   ├── Default Route Table
   │   └── Create a peering connection to destination VPC CIDR and default route table
   └── Route Table Association {3}
       └── Subnet and Route Table Association
           ├── Public
           ├── Private
           └── Database
```