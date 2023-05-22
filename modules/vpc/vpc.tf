# Create a VPC
resource "aws_vpc" "demo" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags = {
    Name = "demovpc"
  }
}

# Create an IGW

resource "aws_internet_gateway" "demoigw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "demoigw"
  }
}

# Create 2 public subnets
resource "aws_subnet" "public1" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr1
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true
  tags = {
    "Name"                                 = "public-eu-west-2a"
    "kubernetes.io/role/elb"               = "1"
    "kubernetes.io/cluster/techdomcluster" = "shared"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr2
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true
  tags = {
    "Name"                                 = "public-eu-west-2b"
    "kubernetes.io/role/elb"               = "1"
    "kubernetes.io/cluster/techdomcluster" = "shared"
  }
}

# Create routetable and associate subnets with them

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route{
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.demoigw.id
    }

  tags = {
    Name = "publicroute"
  }
}

resource "aws_route_table_association" "public-eu-west-2a" {
  subnet_id      = var.subnet_id1
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-eu-west-2b" {
  subnet_id      = var.subnet_id2
  route_table_id = aws_route_table.public.id
}



output "vpc_id" {
  value = aws_vpc.demo.id
}

output "subnet_id1" {
  value = aws_subnet.public1.id
}

output "subnet_id2" {
  value = aws_subnet.public2.id
}
