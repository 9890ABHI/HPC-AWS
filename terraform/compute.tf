resource "aws_instance" "compute" {
  count         = var.compute_count
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.private_subnet.id

  tags = {
    Name = "compute-node-${count.index}"
    Role = "HPC-Compute"
  }
}





# ====== old code ======

# resource "aws_instance" "compute" {
#   count                  = var.compute_count
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.private_subnet.id
#   vpc_security_group_ids = [aws_security_group.compute_sg.id]
#   key_name               = var.key_name
# 
#   tags = {
#     Name = "hpc-compute-${count.index}"
#   }
# }
