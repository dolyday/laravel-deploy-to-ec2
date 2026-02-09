resource "aws_instance" "laravel_server" {
  ami           = "ami-042b4708b1d05f512"
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = data.aws_subnet.default.id
  associate_public_ip_address = true
  vpc_security_group_ids = [data.aws_security_group.allow_http_ssh.id]


  tags = {
    Name = "laravel-deploy-to-ec2"
  }
}

data "aws_security_group" "allow_http_ssh" {
  filter {
    name   = "group-name"
    values = ["allow_http_ssh"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
