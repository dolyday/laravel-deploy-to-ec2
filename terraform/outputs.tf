output "instance_ip" {
  value = aws_instance.laravel_server.public_ip
}

output "rds_endpoint" {
    value = aws_db_instance.mysql_db_instance.address
}
