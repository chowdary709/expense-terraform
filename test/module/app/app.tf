# Define an AWS IAM role resource
resource "aws_iam_role" "role" {
  name = "${var.component}-role"              # Name of the IAM role

  # Define the IAM role's assume role policy document
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",                  # Version of the policy language
    Statement = [
      {
        Action    = "sts:AssumeRole",          # Action to allow (assume role)
        Effect    = "Allow",                   # Effect of the policy (allow)
        Sid       = "",                        # Statement ID (optional)
        Principal = {
          Service = "ec2.amazonaws.com"       # Service to allow assuming the role from (EC2)
        }
      },
    ]
  })

  # Define an inline policy for the IAM role
  inline_policy {
    name   = "${var.component}-policy"        # Name of the inline policy

    # Define the policy document for the inline policy
    policy = jsonencode({
      Version   = "2012-10-17",                # Version of the policy language
      Statement = [
        {
          Sid       = "VisualEditor0",         # Statement ID (optional)
          Effect    = "Allow",                 # Effect of the policy (allow)
          Action    = [
            "kms:Decrypt",                     # List of actions to allow
            "ssm:DescribeParameters",
            "ssm:GetParameterHistory",
            "ssm:GetParametersByPath",
            "ssm:GetParameters",
            "ssm:GetParameter",
          ],
          Resource  = "*",                      # Resource to allow access to (all resources)
        },
      ],
    })
  }

  tags = {
    tag-key = "${var.component}-role"        # Tags for the IAM role (tag-key tag)
  }
}

# Define an AWS IAM instance profile resource
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.component}-role"             # Name of the IAM instance profile
  role = aws_iam_role.role.name              # IAM role associated with the instance profile
}

# Define an AWS launch template resource
resource "aws_launch_template" "template" {
  name                   = "${var.component}" # Name of the launch template
  image_id               = data.aws_ami.ami.id # ID of the AMI to use for launching instances
  instance_type          = var.instance_type  # Instance type for the launched instances
  vpc_security_group_ids = [aws_security_group.security_group.id] # Security group IDs for the instances

  # Define IAM instance profile for the launched instances
  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }

  # Define user data for the launched instances
  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    role_name = var.component                # Name of the IAM role to be passed to user data script
  }))

  # Define tags for the launched instances
  tag_specifications {
    resource_type = "instance"                # Resource type (instance)
    tags = {
      Name = "${var.component}"               # Tags for the launched instances (Name tag)
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = var.component
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = var.subnets

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"  # Use $Latest for the latest version of the launch template
  }

  tag {
    key                 = "project"
    propagate_at_launch = true
    value               = "expense"
  }
}

resource "aws_lb_target_group" "tg" {
  name                 = "${var.component}-tg" # Name of the target group
  port                 = var.app_port          # Port the target group listens on
  protocol             = "HTTP"                # Protocol the target group uses (HTTP)
  vpc_id               = var.vpc_id            # ID of the VPC the target group is associated with
  deregistration_delay = 30                    # Deregistration delay for targets

  # Define health check for the target group
  health_check {
    enabled             = true                 # Whether health checks are enabled
    healthy_threshold   = 2                    # Number of consecutive successful health checks required
    interval            = 5                    # Interval between health checks
    unhealthy_threshold = 2                    # Number of consecutive failed health checks required
    port                = var.app_port         # Port the health check is performed on
    path                = "/"                  # Path for the health check requests
    timeout             = 3                    # Timeout for the health check requests
  }
}
