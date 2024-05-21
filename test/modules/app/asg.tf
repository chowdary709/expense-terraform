resource "aws_autoscaling_group" "asg" {
  name                      = "${var.env}-${var.component}"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 5
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = var.subnets

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}