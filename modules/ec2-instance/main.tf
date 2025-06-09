resource "aws_instance" "web" {
  ami           = var.ec2_ami
  instance_type = var.instance_type
}