#!/bin/bash

dev:
	git pull
	terraform init
	terraform apply -auto-approve -var-file="env-dev/terraform.tfvars"

dev-destroy:
	rm -rf .terraform
	terraform init
	terraform destroy -auto-approve -var-file="env-dev/terraform.tfvars"


