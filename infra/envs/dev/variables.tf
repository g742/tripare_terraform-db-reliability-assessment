variable "aws_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "container_image" {
  type = string
}

variable "container_cpu" {
  type = number
}

variable "container_memory" {
  type = number
}

variable "rds_instance_class" {
  type = string
}

variable "backup_retention_period" {
  type = number
}

variable "deletion_protection" {
  type = bool
}
