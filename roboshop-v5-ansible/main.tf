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

resource "null_resource" "ansible" {
  depends_on = [aws_route53_record.dns_record]
  for_each = var.components

  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      password = "DevOps321"
      host = aws_instance.instance[each.key].private_ip
    }

    inline = [
      "sudo pip-3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/mdevops24/roboshop-ansible main.yml -e env=dev -e role_name=${each.key}"
    ]

  }
}