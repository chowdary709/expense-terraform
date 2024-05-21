dev:
	git pull
	terraform init
	terraform apply -auto-approve -var-file=env-dev/inputs.tfvars

dev-destroy:
	terraform init
	terraform destroy -auto-approve -var-file=env-dev/inputs.tfvars