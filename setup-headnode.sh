#!/bin/bash

# ============================== Update and Install Dependencies ==============================
# ==========================================
# Enterprise HPC Head Node Script
# ==========================================

set -e
set -o pipefail

# ---------- CONFIG ----------
TOTAL_STEPS=6
CURRENT_STEP=0
LOGFILE="bootstrap.log"

# ---------- COLORS ----------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ---------- LOGGING ----------
exec > >(tee -a $LOGFILE) 2>&1

# ---------- FUNCTIONS ----------

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

is_installed() {
    command -v "$1" >/dev/null 2>&1
}

# ---------- START ----------

echo "======================================"
echo "🚀 Starting HPC Head Node"
echo "======================================"
echo ""

# 1️⃣ Update System
step "Updating system packages..."
sudo apt update -y > /dev/null
sudo apt upgrade -y > /dev/null
success "\n \n System updated"

# 2️⃣ Install Base Dependencies
step "Installing base dependencies..."
sudo apt install -y curl unzip gnupg software-properties-common git > /dev/null
success "\n \n Base dependencies installed"

# 3️⃣ Install AWS CLI v2 (Idempotent)
step "Checking AWS CLI..."

if is_installed aws; then
    success "\n \n AWS CLI already installed. Skipping."
else
    ARCH=$(uname -m)

    if [ "$ARCH" = "x86_64" ]; then
        AWS_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
    elif [ "$ARCH" = "aarch64" ]; then
        AWS_URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi

    curl -s "$AWS_URL" -o awscliv2.zip
    unzip -q awscliv2.zip
    sudo ./aws/install > /dev/null
    rm -rf aws awscliv2.zip

    success "\n \n AWS CLI v2 installed"
fi

# 4️⃣ Install Terraform (Idempotent)
step "Checking Terraform..."

if is_installed terraform; then
    success "Terraform already installed. Skipping."
else
    curl -fsSL https://apt.releases.hashicorp.com/gpg | \
        sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

    sudo apt update -y > /dev/null
    sudo apt install -y terraform > /dev/null

    success "\n \n Terraform installed"
fi

# 5️⃣ Install Ansible (Idempotent)
step "Checking Ansible..."

if is_installed ansible; then
    success "\n \n Ansible already installed. Skipping."
else
    sudo apt install -y ansible > /dev/null
    success "\n \n Ansible installed"
fi

# 6️⃣ Verification
step "\n Verifying installations..."

terraform -v
ansible --version | head -n 1
aws --version

success "\n \n All tools verified successfully"

echo "======================================"
echo -e "${GREEN}✅ Completed Successfully!${NC}"
echo "Log file saved as: $LOGFILE"
echo "======================================"






















# ============================================== OlD Version ==============================================
# # ==============================
# # HPC Head Node Bootstrap Script
# # ==============================

# set -e
# set -o pipefail

# # -------- COLORS --------
# RED='\033[0;31m'
# GREEN='\033[0;32m'
# YELLOW='\033[1;33m'
# NC='\033[0m' # No Color

# TOTAL_STEPS=6
# CURRENT_STEP=0

# LOGFILE="bootstrap.log"
# exec > >(tee -a $LOGFILE) 2>&1

# # -------- ERROR HANDLER --------
# error_handler() {
#     echo -e "${RED}"
#     echo "-----------------------------------------"
#     echo "❌ ERROR at line $1"
#     echo "Check log file: $LOGFILE"
#     echo "-----------------------------------------"
#     echo -e "${NC}"
#     exit 1
# }

# trap 'error_handler $LINENO' ERR

# # -------- STEP FUNCTION --------
# step() {
#     CURRENT_STEP=$((CURRENT_STEP + 1))
#     echo -e "${YELLOW}"
#     echo "[${CURRENT_STEP}/${TOTAL_STEPS}] $1"
#     echo -e "${NC}"
# }

# success() {
#     echo -e "${GREEN}✔ $1${NC}"
#     echo ""
# }

# # -------- START SCRIPT --------

# echo "======================================"
# echo "🚀 Starting HPC Head Node "
# echo "======================================"
# echo ""

# # Step 1
# step "Updating system packages..."
# sudo apt update -y > /dev/null
# sudo apt upgrade -y > /dev/null
# success "\n \n System updated"

# # Step 2
# step "Installing base dependencies..."
# sudo apt install -y curl unzip gnupg python3-pip python3-boto software-properties-common git > /dev/null
# success "\n \n Base dependencies installed"

# # Step 3
# step "Installing AWS CLI..."
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" > /dev/null
# unzip awscliv2.zip > /dev/null
# sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin > /dev/null
# rm -rf awscliv2.zip aws
# success "\n \n AWS CLI installed"


# # Step 3
# step "Installing Terraform..."
# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - > /dev/null
# sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /dev/null
# sudo apt update -y > /dev/null
# sudo apt install -y terraform > /dev/null
# success "\n \n Terraform installed"

# # Step 4
# step "Installing Ansible..."
# sudo apt install -y ansible > /dev/null
# success "\n \n Ansible installed"

# # Step 5
# step "Verifying installations..."
# terraform -v
# ansible --version | head -n 1
# aws --version
# success "\n \n All tools verified"

# echo "======================================"
# echo -e "${GREEN}✅ Completed Successfully!${NC}"
# echo "Project directory can now be created."
# echo "Log file saved as: $LOGFILE"
# echo "======================================"