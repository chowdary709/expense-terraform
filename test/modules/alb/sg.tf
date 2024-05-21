resource "aws_security_group" "sg" {
  name        = "${var.env}-${var.alb_type}"
  description = "${var.env}-${var.alb_type}"

  vpc_id = var.vpc_id

  // Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.alb_sg_allow_cidr]  # Allowing HTTP access from the specified CIDR block
  }

  // Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-${var.alb_type}"
  }
}
