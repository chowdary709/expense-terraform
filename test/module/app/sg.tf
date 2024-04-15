# Define an AWS security group resource
resource "aws_security_group" "security_group" {
  name        = var.component                  # Name of the security group
  description = var.component                  # Description of the security group
  vpc_id      = var.vpc_id                     # ID of the VPC to associate the security group with

  # Define an ingress rule allowing HTTP traffic
  ingress {
    description = "HTTP"                       # Description for the ingress rule
    from_port   = var.app_port                 # Port range to allow traffic from
    to_port     = var.app_port                 # Port range to allow traffic to
    protocol    = "tcp"                        # Protocol to allow (TCP in this case)
    cidr_blocks = ["0.0.0.0/0"]                # CIDR blocks to allow traffic from (all IPs)
  }

  # Define an ingress rule allowing SSH traffic
  ingress {
    description = "SSH"                        # Description for the ingress rule
    from_port   = 22                           # Port range to allow SSH traffic from
    to_port     = 22                           # Port range to allow SSH traffic to
    protocol    = "tcp"                        # Protocol to allow (TCP in this case)
    cidr_blocks = ["0.0.0.0/0"]                # CIDR blocks to allow SSH traffic from (all IPs)
  }

  # Define an egress rule allowing all outbound traffic
  egress {
    from_port   = 0                            # Port range to allow outbound traffic from
    to_port     = 0                            # Port range to allow outbound traffic to
    protocol    = "-1"                         # Protocol to allow (all protocols)
    cidr_blocks = ["0.0.0.0/0"]                # CIDR blocks to allow outbound traffic to (all IPs)
  }

  tags = {
    Name = "${var.component}-sg"              # Tags for the security group (Name tag)
  }
}
