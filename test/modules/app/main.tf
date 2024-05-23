resource "aws_launch_template" "template" {
  name = "${var.env}-${var.component}"
  image_id = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]

  user_data = filebase64(templatefile("${path.module}/userdata.sh", {
    role_name = var.component
    env = var.env
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env}-${var.component}"
    }
  }
}


