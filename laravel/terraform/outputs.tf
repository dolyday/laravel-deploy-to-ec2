output "instance_ip" {
  value = aws_instance.laravel_server.public_ip
}