#!/bin/bash


set -e

rm -rf HPC-AWS
git clone https://github.com/9890ABHI/HPC-AWS.git
cd HPC-AWS
chmod +x setup-headnode.sh
