dev:
	rm -rf .terraform
	terraform init
	terraform apply -auto-approve -var-file=inputs.tfvars


dev-destroy:
	rm -rf .terraform
	terraform init
	terraform destroy -auto-approve -var-file=inputs.tfvars

