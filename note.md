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
