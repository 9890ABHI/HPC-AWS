# HPC-AWS

HPC-AWS

before running terra-initiate-node.sh
run or create ssh keygen for shate key

# to check to terraform files

terraform fmt
terraform validate
terraform init
terraform apply

# if terraform stops in between while running and it doesn't come up you can destory it again build that

terraform destroy

rm -rf .terraform
rm terraform.tfstate\*
terraform init
terraform apply

# to get you oun public IP details from

```bash
$ curl ifconfig.me
```
