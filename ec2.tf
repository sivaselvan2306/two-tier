#ec2-1
resource "aws_instance" "web-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address =  true
  subnet_id     = aws_subnet.pubnet1.id
  vpc_security_group_ids =[aws_security_group.pub_sec.id]
  user_data = file("userdata.sh")

  tags = {
    Name = "web-server-1"
  }
}

#ec2-2
resource "aws_instance" "web-2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address =  true
  subnet_id     = aws_subnet.pubnet1.id
  vpc_security_group_ids =[aws_security_group.pub_sec.id]
  user_data = file("userdata.sh")

  tags = {
    Name = "web-server-2"
  }
}