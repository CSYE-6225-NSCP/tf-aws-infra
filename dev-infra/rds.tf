resource "aws_db_parameter_group" "mysql" {
  name        = "csye6225-mysql-params"
  family      = "mysql8.0"
  description = "Custom parameter group for MySQL"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "private-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "mysql" {
  identifier             = "csye6225"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = var.DB_NAME
  username               = var.DB_USER
  password               = var.DB_PASSWORD
  parameter_group_name   = aws_db_parameter_group.mysql.name
  db_subnet_group_name   = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
}