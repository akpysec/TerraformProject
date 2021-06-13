output "web_server_id" {
  value = aws_instance.test_web.id
}

output "web_server_sg" {
  value = aws_security_group.test_web_sg.id
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.id
}

