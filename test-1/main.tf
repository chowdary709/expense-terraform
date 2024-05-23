resource "aws_iam_role" "role" {
  name = "iam-dev"

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
    name = "iam-dev-policy"

    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "VisualEditor0",
          "Effect": "Allow",
          "Action": [
            "ssm:DescribeParameters",
            "ssm:GetParameterHistory",
            "ssm:GetParametersByPath",
            "ssm:GetParameters",
            "ssm:GetParameter"
          ],
          "Resource": "*"
        }
      ]
    })
  }

  tags = {
    tag-key = "iam-dev"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "iam-dev"
  role = aws_iam_role.role.name
}