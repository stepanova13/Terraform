
# DATA SOURCES
data "aws_ami" "amazon_linux_2_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

data "aws_region" "current" {}

# RESOURCES
# Deploy an EC2 instance using Amazon Linux 2 in default VPC in availability zone us-west-2b.
resource "aws_instance" "amazon_linux_2_server" {
  ami = data.aws_ami.amazon_linux_2_ami.id # Reference the data source "aws_ami" attribute - id
  #  instance_type          = var.instance_type                  # Reference the value of the variable specified
  instance_type = var.ec2_types["dev"] # reference a map

  availability_zone      = var.availability_zone
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_rds_ssh_http.id]
  tags = {
    "Region:" = data.aws_region.current.name
    "AZ:"     = var.availability_zone
  }
}

# Create a VPC resource 10.123.0.0/16 in us-west-2.
resource "aws_vpc" "oregon_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "Terraform VPC"
  }
}

# Create a security group to allow 3306, 22, 80 traffic
resource "aws_security_group" "sg_rds_ssh_http" {
  name        = "allow_rds_ssh_http"
  description = "Allow RDS,SSH,HTTP inbound traffic"

  ingress {
    description = "Allows RDS traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.rds_cidr]
  }

  ingress {
    description = "Allows SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = "Allows HTTP traffic"
    from_port   = 80
    to_port     = 80
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
    Name = "allow_rds_ssh_http"
  }
}

