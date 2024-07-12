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
  vpc_id     = aws_vpc.rani-vpc
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "rani-subnet"
  }
}