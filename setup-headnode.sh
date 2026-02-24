#!/bin/bash

# ==============================
# HPC Head Node Bootstrap Script
# ==============================

set -e
set -o pipefail

# -------- COLORS --------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TOTAL_STEPS=5
CURRENT_STEP=0

LOGFILE="bootstrap.log"
exec > >(tee -a $LOGFILE) 2>&1

# -------- ERROR HANDLER --------
error_handler() {
    echo -e "${RED}"
    echo "-----------------------------------------"
    echo "❌ ERROR at line $1"
    echo "Check log file: $LOGFILE"
    echo "-----------------------------------------"
    echo -e "${NC}"
    exit 1
}

trap 'error_handler $LINENO' ERR

# -------- STEP FUNCTION --------
step() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    echo -e "${YELLOW}"
    echo "[${CURRENT_STEP}/${TOTAL_STEPS}] $1"
    echo -e "${NC}"
}

success() {
    echo -e "${GREEN}✔ $1${NC}"
    echo ""
}

# -------- START SCRIPT --------

echo "======================================"
echo "🚀 Starting HPC Head Node Bootstrap"
echo "======================================"
echo ""

# Step 1
step "Updating system packages..."
sudo apt update -y > /dev/null
sudo apt upgrade -y > /dev/null
success "System updated"

# Step 2
step "Installing base dependencies..."
sudo apt install -y curl unzip gnupg software-properties-common awscli git > /dev/null
success "Base dependencies installed"

# Step 3
step "Installing Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - > /dev/null
sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /dev/null
sudo apt update -y > /dev/null
sudo apt install -y terraform > /dev/null
success "Terraform installed"

# Step 4
step "Installing Ansible..."
sudo apt install -y ansible > /dev/null
success "Ansible installed"

# Step 5
step "Verifying installations..."
terraform -v
ansible --version | head -n 1
aws --version
success "All tools verified"

echo "======================================"
echo -e "${GREEN}✅ Bootstrap Completed Successfully!${NC}"
echo "Project directory can now be created."
echo "Log file saved as: $LOGFILE"
echo "======================================"