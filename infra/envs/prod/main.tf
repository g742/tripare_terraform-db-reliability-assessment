terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "ecs" {
  source = "../../modules/ecs"

  environment        = var.environment
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids

  container_image = var.container_image
  container_cpu   = var.container_cpu
  container_memory = var.container_memory
}

module "rds" {
  source = "../../modules/rds"

  environment = var.environment

  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  ecs_security_group_id = module.ecs.ecs_security_group_id

  instance_class          = var.rds_instance_class
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
}
