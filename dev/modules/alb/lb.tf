resource "aws_lb" "alb" {
  name               = "${var.env}-${var.alb_type}"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group.id]
  subnets            = var.subnets
  tags = {
    Environment = "${var.env}-${var.alb_type}"
  }
}

resource "aws_lb_listener" "http" {
  depends_on        = [aws_lb.alb]
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }
}


resource "aws_lb_listener" "listener-https" {
  count             = var.alb_type == "public" ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:666171310914:certificate/d6562e5d-7c7a-4f4e-b1ed-cabec8465b7b"


  default_action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }
}



