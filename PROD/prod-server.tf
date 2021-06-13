resource "aws_instance" "prod_web" {
  ami                    = data.aws_ami.ami_linux_2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.prod_web_sg.id]
  user_data              = file("scripts/prod_user_data_web_server.sh")
  subnet_id              = aws_subnet.public_subnet.id

  tags = {
    Name  = "${element(var.prod_tags, 0)}-SERVER"
    Owner = element(var.prod_tags, 1)
  }
}

resource "aws_security_group" "prod_web_sg" {
  name        = "Allow_WEB"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.prod_ports
    content {
      description = "${element(var.prod_tags, 0)}-PORTS"
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
    Name  = "${element(var.prod_tags, 0)}-SG"
    Owner = element(var.prod_tags, 1)
  }
}


