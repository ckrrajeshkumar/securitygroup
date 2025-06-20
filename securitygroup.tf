resource "aws_vpc" "babaji-vpc"{
  cidr_block = var.vpccidr
  tags={
    Name = var.vpcname
  }
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