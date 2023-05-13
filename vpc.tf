resource "aws_vpc" "jenkins-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "jenkins-vpc"
  }
}


resource "aws_internet_gateway" "jenkins-IGW" {
  vpc_id = aws_vpc.jenkins-vpc.id
  tags = {
    Name = "jenkins-IGW"
  }
}


resource "aws_route_table" "jenkins-pub-RT" {
  vpc_id = aws_vpc.jenkins-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins-IGW.id
  }

  tags = {
    Name = "jenkins-pub-RT"
  }
}

resource "aws_subnet" "jenkins-pub-1" {
  vpc_id                  = aws_vpc.jenkins-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "jenkins-pub-1"
  }
}


resource "aws_route_table_association" "jenkins-pub-1-a" {
  subnet_id      = aws_subnet.jenkins-pub-1.id
  route_table_id = aws_route_table.jenkins-pub-RT.id
}











