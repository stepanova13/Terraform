
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

# create a list
variable "ec2_tags" {
  description = "ec2 tags"
  type        = list(any)
}

variable "vpc_tags" {
  description = "vpc tags"
  type        = list(any)
}

variable "rds_ingress_description" {
  description = "rds ingress"
  type        = string
}

variable "sg_description" {
  type = string
}

variable "sg_name" {
  description = "the name of the sg"
  type        = string
}

variable "sg_tags" {
  description = "tags for the sg"
  type        = list(any)
}

variable "ssh_port" {
  description = "ssh port"
  type        = number
}

variable "ssh_description" {
  description = "ssh description"
  type        = string
}

variable "http_description" {
  description = "http desctiprion"
  type        = string
}

variable "http_port" {
  description = "http port"
  type        = number
}

variable "http_cidr_blocks" {
  description = "http cidr blocks"
  type        = string
}