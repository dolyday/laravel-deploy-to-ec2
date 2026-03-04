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


resource "aws_subnet" "rds_subnet_1" {
    vpc_id            = data.aws_vpc.default.id
    cidr_block        = "172.31.100.0/24"
    availability_zone = "eu-north-1a"

    tags = {
        Name = "rds-subnet-1"
    }
}

resource "aws_subnet" "rds_subnet_2" {
    vpc_id            = data.aws_vpc.default.id
    cidr_block        = "172.31.101.0/24"
    availability_zone = "eu-north-1b"

    tags = {
        Name = "rds-subnet-2"
    }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name = "rds-subnet-group"

    subnet_ids = [
        aws_subnet.rds_subnet_1.id,
        aws_subnet.rds_subnet_2.id
    ]

    tags = {
        Name = "RDS subnet group"
    }
}


resource "aws_security_group" "rds_sg" {
    name   = "rds-security-group"
    vpc_id = data.aws_vpc.default.id

    ingress {
        description     = "Allow MySQL from EC2 only"
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [aws_security_group.ec2_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "RDS security group"
    }
}
