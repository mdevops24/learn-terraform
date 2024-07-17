variable "ami" {
    default = "ami-041e2ea9402c46c32"
    }

resource "aws_instance" "frontend" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0a23eac89d8fb6bf3"]

  tags = {
    Name = "frontend.dev"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z06408271IBTZUNALJ3LD"
  name    = "fe.dev.mdevops24.online"
  type    = "A"
  ttl     = "7"
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "mongo" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0a23eac89d8fb6bf3"]

  tags = {
    Name = "mongo.dev"
  }
}

resource "aws_route53_record" "mongo" {
  zone_id = "Z06408271IBTZUNALJ3LD"
  name    = "mongo.dev.mdevops24.online"
  type    = "A"
  ttl     = "7"
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "catalogue" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0a23eac89d8fb6bf3"]

  tags = {
    Name = "catalogue.dev"
  }
}

resource "aws_route53_record" "catalogue" {
  zone_id = "Z06408271IBTZUNALJ3LD"
  name    = "catalogue.dev.mdevops24.online"
  type    = "A"
  ttl     = "7"
  records = [aws_instance.frontend.private_ip]
}