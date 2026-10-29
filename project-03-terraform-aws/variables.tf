variable "aws_region" {
  description = "AWS region for the lab."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix for resource names."
  type        = string
  default     = "portfolio-lab"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "ami_id" {
  description = "Valid Linux AMI ID in the selected region."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type; check regional availability and pricing."
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "Your approved public IP in CIDR notation, e.g. x.x.x.x/32."
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "allowed_ssh_cidr must be a valid CIDR block."
  }
}
