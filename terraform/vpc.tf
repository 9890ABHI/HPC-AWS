# Create VPC
resource "aws_vpc" "hpc_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "hpc-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.hpc_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "hpc-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.hpc_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "hpc-private-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.hpc_vpc.id

  tags = {
    Name = "hpc-igw"
  }
}


# =====================================

# resource "aws_subnet" "hpc_vpc" {
#   vpc_id                  = aws_vpc.hpc_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   enable_dns_hostnames = true
#   enable_dns_support   = true
# 
#   tags = {
#     Name = "hpc-vpc"
#   }
# }
# 
# resource "aws_subnet" "private_subnet" {
#   vpc_id     = aws_vpc.hpc_vpc.id
#   cidr_block = "10.0.2.0/24"
# 
#   tags = {
#     Name = "private-subnet"
#   }
# }
# 
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.hpc_vpc.id
# }
# 
# 
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.hpc_vpc.id
# 
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
# }
# 
# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }

# ============================================


# resource "aws_vpc" "hpc_vpc" {
#   cidr_block = var.vpc_cidr
# 
#   tags = {
#     Name = "hpc-vpc"
#   }
# }
# 
# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.hpc_vpc.id
#   cidr_block              = var.public_subnet_cidr
#   map_public_ip_on_launch = true
#   availability_zone       = "ap-south-1a"
# 
#   tags = {
#     Name = "hpc-public-subnet"
#   }
# }
# 
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.hpc_vpc.id
# 
#   tags = {
#     Name = "hpc-igw"
#   }
# }
# 
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.hpc_vpc.id
# 
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
# }
# 
# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }