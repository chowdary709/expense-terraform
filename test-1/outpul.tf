output "instance_public_ips" {
  value = aws_instance.expence[*].public_ip
}