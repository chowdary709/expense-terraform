#
#resource "aws_instance" "expence" {
#  count                         = 3
#  ami                           = data.aws_ami.ami.id
#instance_type = var.instance_name[count.index] == "mysql" ? "t3.medium" : "t2.micro"
#  subnet_id                     = var.us-east-1c
#  vpc_security_group_ids        = var.sg
#  user_data                     = base64encode(templatefile("${path.module}/userdata.sh", {
#    role_name = var.instance_name[count.index]  # Use index to get the instance name
#  }))
#  tags = {
#    Name = var.instance_name[count.index]
#  }
#
#instance_market_options {
#    market_type = "spot"
#    spot_options {
#      max_price                        = "0"
#      instance_interruption_behavior   = "stop"
#      spot_instance_type               = "persistent"
#    }
#  }
#}
#
#
#resource "aws_route53_record" "record" {
#  count = 3
#  zone_id = var.zone_id
#  name    = "${var.instance_name[count.index]}.${var.domain}" #interpolation
#  type    = "A"
#  ttl     = 1
#  records = [aws_instance.expence[count.index].private_ip]
#}

resource "aws_instance" "expence" {
  count                         = 3
  ami                           = data.aws_ami.ami.id
  instance_type                 = var.instance_name[count.index] == "mysql" ? "t3.medium" : "t2.micro"
  subnet_id                     = var.us-east-1c
  vpc_security_group_ids        = var.sg
  user_data                     = base64encode(templatefile("${path.module}/userdata.sh", {
    role_name = var.instance_name[count.index]  # Use index to get the instance name
  }))
  tags = {
    Name = var.instance_name[count.index]
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price                        = "0"
      instance_interruption_behavior   = "stop"
      spot_instance_type               = "persistent"
    }
  }

  // Attach IAM role to instance
  iam_instance_profile = {
    name = aws_iam_role.role.name
  }

  // Declare dependency on aws_iam_role.role
  depends_on = [aws_iam_role.role]
}


resource "aws_route53_record" "record" {
  count = 3
  zone_id = var.zone_id
  name    = "${var.instance_name[count.index]}.${var.domain}" #interpolation
  type    = "A"
  ttl     = 1
  records = [aws_instance.expence[count.index].private_ip]
}
