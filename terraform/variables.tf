variable "my_ip" {
  description = "Public IP allowed for SSH"
  type        = string
}

variable "compute_count" {
  description = "Number of compute nodes"
  type        = number
}


variable "key_name" {
  description = "Key pair name"
  type        = string
  default     = "HPC-KEY"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_availability_zone" {
  description = "AWS region availability zone to deploy resources"
  type        = string
}

# ====================================



# variable "my_ip" {
#   description = "Public IP allowed for SSH"
#   type        = string
# }
# 
# variable "compute_count" {
#   description = "Number of compute nodes"
#   type        = number
# }
# 
# 
# variable "key_name" {
#   description = "Key pair name"
#   type        = string
# }
# 
# variable "aws_region" {
#   description = "AWS region to deploy resources"
#   type        = string
# }
# 
# 
# # This defines the entire private network range of your VPC.
# 
# variable "vpc_cidr" {
#   description = "CIDR block for VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }
# 
# # This is a smaller network inside the VPC.
# 
# variable "public_subnet_cidr" {
#   description = "CIDR block for public subnet"
#   type        = string
#   default     = "10.0.1.0/24"
# }