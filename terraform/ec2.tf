resource "aws_instance" "laravel_app_instance" {
    ami           = "ami-042b4708b1d05f512"
    instance_type = var.instance_type
    key_name      = var.key_name

    subnet_id                   = data.aws_subnet.default.id
    associate_public_ip_address = true
    vpc_security_group_ids      = [aws_security_group.ec2_sg.id]


    tags = {
        Name = "Deploy Laravel App to EC2"
    }
}
