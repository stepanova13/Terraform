
# Declare variables

variable "aws_region" {
  description = "define auto region"
  type        = string
}

variable "instance_type" {
  description = "instance type"
  type        = string
}

variable "key_name" {
  description = "key name"
  type        = string
}

variable "availability_zone" {
  description = "az"
  type        = string
}

# create a map
variable "ec2_types" {
  type = map(any)
}

variable "ssh_cidr" {
  description = "the cird block for ssh"
  type        = string
}

variable "rds_cidr" {
  description = "the cidr block for rds"
  type        = string

}

variable "vpc_cidr" {
  description = "the cidr of the vpc"
  type        = string
}

variable "rds_port" {
  description = "the port for RDS"
  type        = number
}

