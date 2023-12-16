#VPC
resource "aws_vpc" "myvpc" {
  cidr_block      = var.cidr_vpc   
  instance_tenancy =  "default"

  tags =  {
    Name = "icu-project"
  }
}

#subnet
#pubnet1
resource "aws_subnet" "pubnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pubnet1
  availability_zone = var.az_pubnet1
  tags = {
    Name = "pub-sub-1"
  }
}
#pubnet2
resource "aws_subnet" "pubnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pubnet2
  availability_zone = var.az_pubnet2
  tags = {
    Name = "pub-sub-2"
  }
}
#pvtnet1
resource "aws_subnet" "pvtnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pvtnet1
  availability_zone = var.az_pvtnet1

  tags = {
    Name = "pvt-sub-1"
  }
}

#pvtsub2
resource "aws_subnet" "pvtnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pvtnet2
  availability_zone = var.az_pvtnet2

  tags = {
    Name = "pvt-sub-2"
  }
}

#IGW
resource "aws_internet_gateway" "tigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "t-igw"
  }
}
#nat1
resource "aws_nat_gateway" "pvtnat1" {
  allocation_id = aws_eip.eip1.id
 subnet_id     = aws_subnet.pubnet1.id

tags = {
 Name = "t-NAT1"
}
}
#nat2
resource "aws_nat_gateway" "pvtnat2" {
 allocation_id = aws_eip.eip2.id
subnet_id     = aws_subnet.pubnet2.id

 tags = {
  Name = "t-NAT2"
 }
}
#pub-rt1
resource "aws_route_table" "pubrt1" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tigw.id
  }

  tags = {
    Name = "pubrt1"
  }
}
#pub-rt2
resource "aws_route_table" "pubrt2" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tigw.id
  }

  tags = {
    Name = "pubrt2"
  }
}
#pvtrt1
resource "aws_route_table" "pvtrt1" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pvtnat1.id
  }

  tags = {
    Name = "pvtrt1"
  }
}

#pvtrt2
resource "aws_route_table" "pvtrt2" {
 vpc_id = aws_vpc.myvpc.id

route {
 cidr_block = "0.0.0.0/0"
gateway_id = aws_nat_gateway.pvtnat2.id
}

tags = {
 Name = "pvtrt2"
}
}
#EIP1
resource "aws_eip" "eip1" {
  vpc = true
  
}
resource "aws_eip" "eip2" {
   vpc = true
}

#Routetableass
#pub net asc 1
resource "aws_route_table_association" "pubascn1" {
  subnet_id      = aws_subnet.pubnet1.id
  route_table_id = aws_route_table.pubrt1.id
}

#pub net asc2
 resource "aws_route_table_association" "pubasc2" {
  subnet_id      = aws_subnet.pubnet2.id
  route_table_id = aws_route_table.pubrt2.id
}
#pvt net asc1
 resource "aws_route_table_association" "pvtasc1" {
  subnet_id      = aws_subnet.pvtnet1.id
  route_table_id = aws_route_table.pvtrt1.id
}
#pvt net asc2
 resource "aws_route_table_association" "pvtasc2" {
 subnet_id      = aws_subnet.pvtnet2.id
route_table_id = aws_route_table.pvtrt2.id
}
#pub-seg
resource "aws_security_group" "pub_sec" {
  name        = "public-seg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
 ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  egress {

    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}
#pvt-seg
resource "aws_security_group" "pvt_sec" {
  name        = "pvt-seg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.pub_sec.id]
    
  }
 ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.pub_sec.id]
    
  }
  ingress {
    description      = "mysql"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.pub_sec.id]
  }
  egress {

    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups = [aws_security_group.pub_sec.id]
  }
  tags = {
    Name = "pvt-sec"
  }
}