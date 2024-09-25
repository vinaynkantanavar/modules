variable "region" {
  description = "specify region"
  default = "us-west-1"
  type = string
}
variable "ipv4" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the subnets"
  type        = string
}

variable "name" {
  description = "The name prefix for all VPC components"
  type        = string
  default = "sf-arc"
}
