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
        security_groups = [data.aws_security_group.allow_http_ssh_mysql.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "RDS SG"
    }
}


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

    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
}
