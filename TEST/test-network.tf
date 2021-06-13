# Creating a VPC, Tagging with given name for the environment
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${element(var.test_tags, 0)}-VPC"
  }
}

# Creating Private Subnet in a VPC ^
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${element(var.test_tags, 0)}-PRIVATE-SUBNET"
  }
}

# Creating a Route Table for Private subnet ^
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${element(var.test_tags, 0)}-PRIVATE-ROUTE-TABLE"
  }
}

# Associating private Subnets with Route Table
resource "aws_route_table_association" "private_routes_subnets_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet.id
}
