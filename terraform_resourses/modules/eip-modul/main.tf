resource "aws_eip" "my_eip" {
  domain = "vpc"
  instance = var.ec2id

  

}
