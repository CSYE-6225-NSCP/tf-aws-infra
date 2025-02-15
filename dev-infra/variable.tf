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