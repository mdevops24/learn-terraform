resource "aws_route53_record" "frontend" {
  zone_id = "Z06408271IBTZUNALJ3LD"
  name    = "test1.mdevops24.online"
  type    = "A"
  ttl     = 15
  records = [var.private_ip]
}

variable "private_ip" {}