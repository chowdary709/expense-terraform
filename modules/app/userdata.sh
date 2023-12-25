#!/bin/bash
dnf install python3.11-pip -y
pip3.11-pip install boto3 botocore
ansible-pull -i loacalhost, -U https://github.com/chowdary709/expense-ansible main.yml -e role_name=${role_name}

