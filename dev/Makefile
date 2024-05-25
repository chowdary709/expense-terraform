dev:
	git pull
	rm -rf .terraform
	terraform init
	terraform apply -auto-approve -var-file=env-dev/inputs.tfvars

prod:
	rm -rf .terraform
	terraform init
	terraform apply -auto-approve -var-file=env-prod/inputs.tfvars

dev-destroy:
	rm -rf .terraform
	terraform init
	terraform destroy -auto-approve -var-file=env-dev/inputs.tfvars

prod-destroy:
	rm -rf .terraform
	terraform init
	terraform destroy -auto-approve -var-file=env-prod/inputs.tfvars
