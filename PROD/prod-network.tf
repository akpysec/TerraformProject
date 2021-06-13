# Creating a VPC, Tagging with given name for the environment
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${element(var.prod_tags, 0)}-VPC"
  }
}

# Creating Internet Gateway attached to VPC created ^
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${element(var.prod_tags, 0)}-IGW"
  }
}

# Creating Public Subnets in a VPC ^
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${element(var.prod_tags, 0)}-PUBLIC-SUBNET"
  }
}

# Creating a Route Table for public subnets ^
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${element(var.prod_tags, 0)}-PUBLIC-ROUTE-TABLE"
  }
}

# Associating Public Subnets with Route Table
resource "aws_route_table_association" "public_routes_subnets_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}
