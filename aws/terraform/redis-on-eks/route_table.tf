# Create Custom Route Table
resource "aws_route_table" "ProdRouteTable" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_gw.id
  }
  tags = {
    Name = "Prod_RouteTable"
  }
}

