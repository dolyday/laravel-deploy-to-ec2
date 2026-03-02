resource "aws_instance" "laravel_app_instance" {
    ami           = "ami-042b4708b1d05f512"
    instance_type = var.instance_type
    key_name      = var.key_name

    subnet_id                   = data.aws_subnet.default.id
    associate_public_ip_address = true
    vpc_security_group_ids      = [data.aws_security_group.allow_http_ssh_mysql.id]


    tags = {
        Name = "deploy-laravel-app-to-ec2"
    }
}

data "aws_security_group" "allow_http_ssh_mysql" {
    filter {
        name   = "group-name"
        values = ["allow-http-ssh-mysql"]
    }

    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}
