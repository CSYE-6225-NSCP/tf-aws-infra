variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {

}

variable "private_subnet_cidrs" {

}

variable "availability_zones" {
  type = list(string)
}

variable "public_route_cidr" {
  type = string
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}


variable "app_port" {
  description = "Port on which the application runs"
  type        = number
}

variable "ami_id" {
  description = "Custom AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Size of the root EBS volume"
  type        = number
  default     = 25
}

variable "root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp2"
}