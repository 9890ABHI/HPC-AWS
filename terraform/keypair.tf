resource "aws_key_pair" "deployer" {
  key_name   = "TEST_ONE"
  public_key = file("~/.ssh/id_rsa.pub")
}