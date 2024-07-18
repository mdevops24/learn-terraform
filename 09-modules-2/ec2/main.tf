resource "aws_instance" "test" {
  ami           = "ami-041e2ea9402c46c32"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0a23eac89d8fb6bf3"]

  tags = {
    Name = "test"
  }
}

output "private_ip" {
  value = aws_instance.test.private_ip
}
