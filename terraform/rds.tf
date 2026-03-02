resource "aws_db_instance" "mysql_db_instance" {
    identifier        = "laravel-mysql"
    engine            = "mysql"
    engine_version    = "8.4.7"
    instance_class    = "db.t3.micro"
    allocated_storage = 20

    db_name  = "laravel"
    username = var.db_username
    password = var.db_password

    publicly_accessible = false
    skip_final_snapshot = true

    vpc_security_group_ids = [aws_security_group.allow_http_ssh_mysql.id]
    db_subnet_group_name   = aws_db_subnet_group.main.name
}
