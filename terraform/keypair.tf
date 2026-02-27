resource "aws_key_pair" "deployer" {
  key_name   = "HPC-KEY"
  public_key = file("~/.ssh/id_rsa.pub")
}