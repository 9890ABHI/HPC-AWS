resource "aws_instance" "compute" {
  count         = var.compute_count
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.hpc_sg.id]

  tags = {
    Name = "HPC-Compute-${count.index + 1}"
  }
}