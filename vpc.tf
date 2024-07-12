# create a vpc
resource "aws_vpc" "rani-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ranivpc"
  }
}