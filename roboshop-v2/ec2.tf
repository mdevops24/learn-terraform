variable "ami" {
    default = "ami-041e2ea9402c46c32"
  }

variable "instance_type" {
   default = "t2.micro"
   }

variable "security_group_ids"  {
    default = "sg-0a23eac89d8fb6bf3"
   }

variable "zone_id"  {
    default = "Z06408271IBTZUNALJ3LD"
   }
variable "domain_name" {
   default = "mdevops24.online"
   }

resource "aws_instance "frontend" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "frontend.dev"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = var.zone_id
  name    = "fe.dev.${var.domain_name}"
  type    = "A"
  ttl     = "7"
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "mongo" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "mongo.dev"
  }
}

resource "aws_route53_record" "mongo" {
  zone_id = var.zone_id
  name    = "fe.dev.${var.domain_name}"
  type    = "A"
  ttl     = "7"
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "catalogue" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "catalogue.dev"
  }
}

resource "aws_route53_record" "catalogue" {
  zone_id = var.zone_id
  name    = "fe.dev.${var.domain_name}"
  type    = "A"
  ttl     = "7"
  records = [aws_instance.frontend.private_ip]
}