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
    Name = "rani-subnet"
  }
}

# create a subnet for rani db
resource "aws_subnet" "rani-subnet2" {
  vpc_id     = aws_vpc.rani-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = "true" 
  tags = {
    Name = "rani-subnet"
  }
}