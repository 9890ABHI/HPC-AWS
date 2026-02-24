#!/bin/bash

set -e

echo "======================================="
echo "   AWS HPC Cluster Deployment Script"
echo "======================================="

# Ask Public IP
read -p "Enter your Public IP: " MYIP
if [[ ! $MYIP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo "Invalid IP format."
    exit 1
fi

# Ask AMI ID
# read -p "Enter AMI ID (example: ami-1234567890abcdef0): " AMI_ID
# if [[ ! $AMI_ID =~ ^ami- ]]; then
#     echo "Invalid AMI format."
#     exit 1
# fi

# Ask Key Name
read -p "Enter Key Pair Name: " KEY_NAME
if [ -z "$KEY_NAME" ]; then
    echo "Key name cannot be empty."
    exit 1
fi

# Ask Compute Count
read -p "Enter number of compute nodes: " COMPUTE_COUNT
if ! [[ "$COMPUTE_COUNT" =~ ^[0-9]+$ ]]; then
    echo "Compute count must be a number."
    exit 1
fi


read -p "Enter AWS Region (example: ap-south-1): " AWS_REGION
if [ -z "$AWS_REGION" ]; then
    echo "AWS region cannot be empty."
    exit 1
fi


# Export Terraform Variables
export TF_VAR_my_ip="$MYIP/32"
export TF_VAR_compute_count="$COMPUTE_COUNT"
export TF_VAR_ami_id="$AMI_ID"
export TF_VAR_key_name="$KEY_NAME"
export TF_VAR_aws_region="$AWS_REGION"


echo "Running Terraform Init..."
terraform init

echo "Running Terraform Apply..."
terraform apply -auto-approve

echo "Deployment Completed Successfully!"