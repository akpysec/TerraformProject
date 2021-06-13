resource "aws_instance" "test_web" {
  ami                    = data.aws_ami.ami_linux_2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.test_web_sg.id]
  user_data              = file("scripts/test_user_data_web_server.sh")
  subnet_id              = aws_subnet.private_subnet.id

  tags = {
    Name  = "${element(var.test_tags, 0)}-SERVER"
    Owner = element(var.test_tags, 1)
  }
}

resource "aws_security_group" "test_web_sg" {
  name        = "Allow_WEB_SSH"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.test_ports
    content {
      description = "${element(var.test_tags, 0)}-PORTS"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${element(var.test_tags, 0)}-SG"
    Owner = element(var.test_tags, 1)
  }
}


