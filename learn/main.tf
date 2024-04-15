resource "aws_instance" "instance" {
  ami                          = data.aws_ami.ami.id
  instance_type                = "t2.micro"
  associate_public_ip_address  = true
  # vpc_security_group_ids       = ""

  tags = {
      Name = "hello"
    }
  }