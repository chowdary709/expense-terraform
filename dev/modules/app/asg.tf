resource "aws_autoscaling_group" "asg" {
  name                = "${var.env}-${var.component}"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets
  target_group_arns   = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "template" {
  name                   = "${var.env}-${var.component}"
  image_id               = data.aws_ami.ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    role_name = var.component,
    env       = var.env
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-${var.component}"
    }
  }
}

# Health checks

resource "aws_lb_target_group" "tg" {
  name     = "${var.env}-${var.component}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 5
    unhealthy_threshold = 2
    port                = var.app_port
    path                = "/health"
    timeout             = 3
  }
}



