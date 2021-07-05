#!/bin/sh
CONFIG="state-bucket.config"
# TFVARS="production.tfvars"
if [ "$1" = "initialize" ];then
    echo "Terraform Initiazling........."
    terraform init -backend-config=${CONFIG}
elif [ "$1" = "plan" ];then
    terraform init -backend-config=${CONFIG}
    terraform plan 
elif [ "$1" = "apply" ];then
    terraform init -backend-config=${CONFIG}
    terraform apply  -auto-approve
elif [ "$1" = "taint" ];then
    echo "By using the taint command, we can just run the Ansible portion not touching (create or destroy) the AWS instance. For example, we can run terraform apply after just tainting a Null resource "
    terraform taint null_resource.test_box
    #  terraform taint null_resource.jain
    terraform apply --auto-approve
elif [ "$1" = "destroy" ];then
    terraform init -backend-config=${CONFIG}
    terraform destroy  -auto-approve
fi