
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
# Deploy an EC2 instance using Amazon Linux 2 in default VPC 
resource "aws_instance" "amazon_linux_2_server" {
  ami = data.aws_ami.amazon_linux_2_ami.id # Reference the data source "aws_ami" attribute - id
  #  instance_type          = var.instance_type                  # Reference the value of the variable specified
  instance_type          = var.ec2_types["dev"] # reference a map
  availability_zone      = var.availability_zone
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_rds_ssh_http.id]
  tags = {
    (var.ec2_tags[0]) = data.aws_region.current.name
    (var.ec2_tags[1]) = var.availability_zone
  }
}

# Create a VPC resource
resource "aws_vpc" "_vpc_" {
  cidr_block = var.vpc_cidr
  tags = {
    (var.vpc_tags[0]) = var.vpc_tags[1]
  }
}

# Create a security group
resource "aws_security_group" "sg_rds_ssh_http" {
  name        = var.sg_name
  description = var.sg_description

  ingress {
    description = var.rds_ingress_description
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = var.protocol
    cidr_blocks = [var.rds_cidr]
  }

  ingress {
    description = var.ssh_description
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = var.http_description
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.protocol
    cidr_blocks = [var.http_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    (var.sg_tags[0]) = var.sg_tags[1]
  }
}

