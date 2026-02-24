resource "aws_instance" "master" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.hpc_sg.id]

  tags = {
    Name = "HPC-Master"
  }
}