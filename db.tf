resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.pvt_sec.id]
  availability_zone = var.availability_zone_db
  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
   
}
resource "aws_db_subnet_group" "db_subnet" {
  name       = "main"
  subnet_ids = [aws_subnet.pvtnet1.id,aws_subnet.pvtnet2.id]

  tags = {
    Name = "dbsubgp" 
  }
}