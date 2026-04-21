provider "aws" {
  region = var.region
}

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-north-1b"
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "eu-north-1a"
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-north-1b"
}

resource "aws_internet_gateway" "IGW-pro" {
    vpc_id = aws_vpc.main-vpc.id
  
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main-vpc.id
}

resource "aws_route" "igw" {
    route_table_id = aws_route_table.rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-pro.id
  
}

resource "aws_route_table_association" "public-associate-1" {
    subnet_id = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.rt.id
  
}
resource "aws_route_table_association" "public-associate-2" {
    subnet_id = aws_subnet.public-subnet-2.id
    route_table_id = aws_route_table.rt.id
  
}

resource "aws_security_group" "app-sg" {
    vpc_id = aws_vpc.main-vpc.id

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.main-vpc.id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [aws_security_group.app-sg.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "app-server" {
  ami = "ami-0a0823e4ea064404d"
  instance_type = var.instance_type
  subnet_id = aws_subnet.public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.app-sg.id]
  key_name = var.key_name
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install openjdk-17-jdk -y
  EOF

  tags = {
    Name = "app-pro"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name = "db-subnet"
  subnet_ids = [aws_subnet.private-subnet-1.id,aws_subnet.private-subnet-2.id]
}

resource "aws_db_instance" "rds" {
  allocated_storage = 20
  engine = "postgres"
  instance_class = "db.t3.micro"
  username = var.db_username
  password = var.db_password
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
}

resource "aws_lb" "app_lb" {
  name = "app-lb"
  internal = false
  load_balancer_type = "application"

  subnets = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]
}

resource "aws_lb_target_group" "app-tg" {
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.main-vpc.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}
