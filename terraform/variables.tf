variable "my_ip" {
  description = "Public IP allowed for SSH"
  type        = string
}

variable "compute_count" {
  description = "Number of compute nodes"
  type        = number
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}