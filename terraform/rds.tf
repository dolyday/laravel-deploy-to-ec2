resource "aws_db_instance" "mysql_db_instance" {
    identifier        = "laravel-mysql"
    engine            = "mysql"
    instance_class    = "db.t3.micro"
    allocated_storage = 20

    db_name  = "laravel"
    username = var.db_username
    password = var.db_password

    publicly_accessible = false
    skip_final_snapshot = true
}
