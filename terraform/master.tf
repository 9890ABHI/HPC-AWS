
# Master Node Configration

resource "aws_instance" "master" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.master_sg.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "hpc-master"
  }
}


# Compute Nodes Configration

resource "aws_instance" "compute" {
  count                  = var.compute_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.compute_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = {
    Name = "hpc-compute-${count.index}"
  }
}


# ==== Old Configrations

# resource "aws_instance" "master" {
#   ami = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.deployer.key_name
# 
#   vpc_security_group_ids = [aws_security_group.hpc_sg.id]
# 
#   tags = {
#     Name = "HPC-Master"
#   }
# }