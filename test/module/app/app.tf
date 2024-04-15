resource "aws_security_group" "security_group" {
  name        = var.component
  description = var.component
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-sg"
  }
}

resource "aws_iam_role" "role" {
  name = "${var.component}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "${var.component}-policy"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "kms:Decrypt",
            "ssm:DescribeParameters",
            "ssm:GetParameterHistory",
            "ssm:GetParametersByPath",
            "ssm:GetParameters",
            "ssm:GetParameter"
          ],
          "Resource" : "*"
        }
      ]
    })
  }

  tags = {
    tag-key = "${var.component}-role"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.component}-role"
  role = aws_iam_role.role.name
}

resource "aws_launch_template" "template" {
  name                   = "${var.component}"
  image_id               = data.aws_ami.ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]


  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    role_name = var.component
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.component}"
    }
  }
}