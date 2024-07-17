resource "aws_instance" "instance" {

  #count = length(var.components)
    for_each = var.components

  ami           = data.aws_ami.ami.image_id
  #instance_type = var.instance_type
  instance_type = each.value["instance_type"]

  vpc_security_group_ids = data.aws_security_groups.sg.ids

  tags = {
    #Name = "frontend.dev"
    #Name = "${var.components[count.index]}.dev"
    Name = "${each.key}.dev"
  }
}

resource "aws_route53_record" "dns_record" {
  #count = length(var.components)
  for_each = var.components

  zone_id = data.aws_route53_zone.zone.zone_id

  #name    = "frontend.dev.${var.domain_name}"
  #name    = "${var.components[count.index]}.dev.${var.domain_name}"
  name     = "${each.key}.dev.${var.domain_name}"

  type    = "A"
  ttl     = 7
  #records = [aws_instance.frontend.private_ip]
  #records = [aws_instance.instance[count.index].private_ip]
  records = [aws_instance.instance[each.key].private_ip]
}
