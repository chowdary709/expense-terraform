resource "aws_route53_record" "www" {
  depends_on = [aws_lb.alb]
  zone_id    = var.zone_id
  name       = var.dns_name
  type       = "CNAME"
  ttl        = 30
  records    = [aws_lb.alb.dns_name]
}