#!/bin/bash

dnf install python3.11-pip ansible -y >/opt/userdata.sh
pip3.11-pip install boto3 botocore >/opt/userdata.sh
ansible-pull -i localhost, -U https://github.com/chowdary709/infra-ansible main.yml -e role_name=${role_name} -e env=${var.env} >/opt/userdata.sh
