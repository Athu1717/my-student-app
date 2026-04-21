variable "region" {
  default = "eu-north-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.3.0/24"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "key_name" {
  default = "devops-1"
}

