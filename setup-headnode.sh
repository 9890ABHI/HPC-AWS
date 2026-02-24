#!/bin/bash

set -e

echo "======================================"
echo " HPC Head Node Bootstrap Starting..."
echo "======================================"

# Update System
echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

# Install Required Packages
echo "Installing base dependencies..."
sudo apt install -y \
    curl \
    unzip \
    gnupg \
    software-properties-common \
    awscli \
    git

# Install Terraform
echo "Installing Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository \
  "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update -y
sudo apt install -y terraform

# Install Ansible
echo "Installing Ansible..."
sudo apt install -y ansible

# Verify installations
echo "======================================"
echo "Installed Versions:"
echo "======================================"
terraform -v
ansible --version | head -n 1
aws --version

# Create Project Structure
echo "Creating project directory..."
mkdir -p ~/aws-hpc-cluster/{terraform,ansible}
mkdir -p ~/aws-hpc-cluster/ansible/roles

echo "======================================"
echo "Bootstrap Completed Successfully!"
echo "Project directory: ~/aws-hpc-cluster"
echo "======================================"