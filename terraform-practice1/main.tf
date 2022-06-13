terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-west-2"
  profile = "tf-cli-west2"
}

# Deploy an EC2 instance using Amazon Linux 2 in default VPC in availability zone us-west-2b.
resource "aws_instance" "amazon_linux_2_server" {
  ami                  = "ami-0ca285d4c2cda3300"
  instance_type        = "t2.micro"
  availability_zone    = "us-west-2b"
  key_name             = "oregon-key-pair"
  tags = {
    "Name" = ":) Hello Terraform World"
  }
}


# Create a VPC resource 10.123.0.0/16 in us-west-2.
resource "aws_vpc" "oregon_vpc" {
  cidr_block = "10.123.0.0/16"
  tags = {
    "Name" = "Terraform VPC"
  }
}

