resource "aws_instance" "master" {
  ami           = "ami-0b6c6ebed2801a5cb"
  instance_type = "t2.micro"
  key_name      = "TEST-ONE"

  vpc_security_group_ids = [aws_security_group.hpc_sg.id]
  subnet_id              = aws_subnet.public.id

  tags = {
    Name = "HPC-Master"
  }
}