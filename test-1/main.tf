resource "aws_instance" "expence" {
  count                         = 3
  ami                           = data.aws_ami.ami.id
  instance_type                 = var.instance_name == "mysql" ? "t3.medium" : "t2.micro"
  subnet_id                     = var.us-east-1c
  associate_public_ip_address   = true
  vpc_security_group_ids        = var.sg

  tags = {
    name = var.instance_name
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price                        = "0"
      instance_interruption_behavior   = "stop"
      spot_instance_type               = "persistent"
    }
  }
}

#user_data                     = base64encode(templatefile("${path.module}/userdata.sh", {
#  role_name = var.instance_name  # Passing instance name instead of type
#}))

resource "aws_route53_record" "www" {
  count   = 3
  zone_id = var.Zone_id
  name    = "aws_instance.expence[count.index].roboshop.internal"
  type    = "A"
  ttl     = "1"
  records = [aws_instance.expence[count.index].private_ip]
}
