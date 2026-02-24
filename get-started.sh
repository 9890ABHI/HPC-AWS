#!/bin/bash


set -e

echo "======================================"
echo "🚀 removing old repo "
echo "======================================"
echo ""

rm -rf HPC-AWS

echo "======================================"
echo "🚀 cloning new repo "
echo "======================================"
echo ""

git clone https://github.com/9890ABHI/HPC-AWS.git
cd HPC-AWS

echo "======================================"
echo "🚀 changing permissions setup file for excute it"
echo "======================================"
echo ""

chmod +x setup-headnode.sh terraform/terra-initiate-node.sh