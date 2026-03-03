resource "aws_security_group" "ec2_sg" {
    name        = "ec2-sg"
    description = "Security group for EC2 instance"
    vpc_id      = data.aws_vpc.default.id

    ingress {
        description = "Allow HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow Port 8080"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "EC2 security group"
    }
}

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
