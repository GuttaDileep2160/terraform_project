terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
  }

  backend "s3" {
    bucket = "dileep-webapp-demo"
    key    = "dileep/terraform/remote/s3/terraform.tfstate"
    region = "ap-south-1"

  }
}
provider "aws" {
  # Configuration options
  region = "ap-south-1"

}

#creating the vpc infra
resource "aws_vpc" "project-vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "project_vpc"
  }
}

#creating the public subnets
resource "aws_subnet" "project-subnet-1a" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "project-Subnet-1a"
  }
}

#create public subnets
resource "aws_subnet" "project-subnet-1b" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "project-Subnet-1b"
  }
}

#create private subnets
resource "aws_subnet" "project-private-subnet-1a" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.10.3.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "project-private-Subnet-1a"
  }
}

#create private subnets
resource "aws_subnet" "project-private-subnet-1b" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.10.4.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "project-private-Subnet-1b"
  }
}

#creating Internet Gateway
resource "aws_internet_gateway" "Project_IG" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "project_IG"
  }
}

#creating route table
resource "aws_route_table" "webapp-project-route-table" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Project_IG.id
  }

  tags = {
    Name = "webapp-project-route-table"
  }
}

#create route table association
resource "aws_route_table_association" "webapp-RT-association-1A" {
  subnet_id      = aws_subnet.project-subnet-1a.id
  route_table_id = aws_route_table.webapp-project-route-table.id
}

resource "aws_route_table_association" "webapp-RT-association-1B" {
  subnet_id      = aws_subnet.project-subnet-1b.id
  route_table_id = aws_route_table.webapp-project-route-table.id
}





