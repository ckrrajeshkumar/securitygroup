resource "aws_vpc" "babaji-vpc"{
  cidr_block = var.vpccidr
  tags={
    Name = var.vpcname
  }
}
resource "aws_subnet" "babaji-pub"{
  vpc_id = aws_vpc.babaji-vpc.id
  cidr_block = var.pubsubcidr
  availability_zone = var.pubaz
  map_public_ip_on_launch = true
  tags={
    Name = var.pubsubname
  }
}
resource "aws_vpc" "babaji-pri"{
  vpc_id = aws_vpc.babaji-vpc.id
  cidr_block = var.prisubcidr
  availability_zone = var.priaz
  tags= {
    Name = var.prisubname
  }
}
resource "aws_internet_gateway" "babaji-igw"{
  vpc_id =aws_vpc.babaji-vpc.id
  tags={
    Name = var.babajiigw
  }
}
resource "aws_route_table" "babaji-rt"{
  vpc_id = aws_vpc.babaji-vpc.id
  route{
    cidr_block = var.rtcidr
    gateway_id = aws_internet_gateway.babaji-igw.id
  }
  tags={
    Name = var.rtname
  }
}
resource "aws_route_table_association" "pubrt"{
  route_table_id = aws_route_table.babaji-rt.id
  subnet_id = aws_subnet.babaji-pub.id
}
resource "aws_security_group" "babajiSG"{
  description = "Allow SSH, HTTP and HTTPs"
  vpc_id = aws_vpc.babaji-vpc.id
  ingress {
    description ="allow ssh"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_block = var.inboundcidr
  }
  ingress {
    description ="allow HTTP"
    from_port ="80"
    to_port ="80"
    protocol ="tcp"
    cidr_block = var.inboundcidr1
  }
  ingress {
    description ="allow https"
    from_port ="443"
    to_port ="443"
    protocol = "tcp"
    cidr_block = var.inboundcidr2
  }
  egress {
    description= "allow outbound traffic"
    from_port  = "0"
    to_port    = "0"
    protocol   = "-1"
    cidr_block = var.outboundcidr
  }
  tags={
    Name = var.sgname
  }
}