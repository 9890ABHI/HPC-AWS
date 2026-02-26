resource "aws_instance" "compute" {
  count         = var.compute_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.master_sg.id]

  tags = {
    Name = "HPC-Compute-${count.index + 1}"
  }
}