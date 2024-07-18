provider "aws" {
  region = "us-west-2" # Change this to your preferred region
}

resource "aws_vpc" "assignment" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "assignment"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.assignment.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a" # Change this to your preferred availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "assignment"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.assignment.id
  tags = {
    Name = "assignment"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.assignment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "assignment"
  }
}

resource "aws_route_table_association" "my_route_table_assoc" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.assignment.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["142.250.183.100/32"]
  }

  tags = {
    Name = "assignment"
  }
}

resource "aws_instance" "instance" {
  count                  = 2
  ami                    = "ami-0aff18ec83b712f05" # Ubuntu 20.04 AMI ID for us-west-2
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "ubuntu-${count.index + 1}"
  }

  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /home/ubuntu/.ssh
              echo '${file(var.public_key_path)}' >> /home/ubuntu/.ssh/authorized_keys
              chown -R ubuntu:ubuntu /home/ubuntu/.ssh
              chmod 700 /home/ubuntu/.ssh
              chmod 600 /home/ubuntu/.ssh/authorized_keys
              EOF
}


output "instance_public_ip" {
  value = aws_instance.instance.*.public_ip
}
