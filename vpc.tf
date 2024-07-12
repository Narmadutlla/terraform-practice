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
