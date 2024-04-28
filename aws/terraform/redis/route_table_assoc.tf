# Create Associate Subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.RedisSubnet1.id
  route_table_id = aws_route_table.RedisRouteTable.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.RedisSubnet2.id
  route_table_id = aws_route_table.RedisRouteTable.id
}

