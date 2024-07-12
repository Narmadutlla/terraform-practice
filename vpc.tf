# create a vpc
resource "aws_vpc" "rani-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ranivpc"
  }
}

# create subnet for rani web server
resource "aws_subnet" "rani-subnet1" {
  vpc_id     = aws_vpc.rani-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = "true" 
  tags = {
    Name = "rani-web-subnet"
  }
}

# create a subnet for rani app
resource "aws_subnet" "rani-app-subnet" {
  vpc_id     = aws_vpc.rani-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = "true" 
  tags = {
    Name = "rani-app-subnet"
  }
}


# create a subnet for rani db
resource "aws_subnet" "rani-db-subnet" {
  vpc_id     = aws_vpc.rani-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = "false" 
  tags = {
    Name = "rani-db-subnet"
  }
}

# create internet gateway for rani
resource "aws_internet_gateway" "rani_gw" {
  vpc_id = aws_vpc.rani-vpc.id

  tags = {
    Name = "rani_gw"
  }
}

# create a public route table
resource "aws_route_table" "rani_rt" {
  vpc_id = aws_vpc.rani-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rani_gw.id
  }

  tags = {
    Name = "rani-rt"
  }
}

# create a private route table
resource "aws_route_table" "rani_rt_p" {
  vpc_id = aws_vpc.rani-vpc.id

  tags = {
    Name = "rani-rt-p"
  }
}

resource "aws_route_table_association" "rani_web_rts" {
  subnet_id      = aws_subnet.rani-subnet1.id
  route_table_id = aws_route_table.rani_rt_p.id
}

resource "aws_route_table_association" "rani_db_rts" {
  subnet_id      = aws_subnet.rani-db-subnet.id
  route_table_id = aws_route_table.rani_rt_p.id

  resource "aws_route_table_association" "rani_app_rts" {
  subnet_id      = aws_subnet.rani-app-subnet.id
  route_table_id = aws_route_table.rani_rt_p.id