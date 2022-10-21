resource "aws_nat_gateway" "Project_NATGW" {
  allocation_id = aws_eip.nat_gateway_EIP.id
  subnet_id     = aws_subnet.project-subnet-1b.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.Project_IG]
}


#creating Internet Gateway
resource "aws_internet_gateway" "Project_IG" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "project_IG"
  }
}


resource "aws_eip" "nat_gateway_EIP" {
  vpc = true
}


resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Project_IG.id
  }
}

resource "aws_route_table_association" "nat_gateway_association" {
  subnet_id = aws_subnet.project-subnet-1b.id
  route_table_id = aws_route_table.nat_gateway.id
}