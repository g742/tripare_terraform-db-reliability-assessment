aws_region = "us-east-2"

environment = "prod"

vpc_cidr = "10.20.0.0/16"

availability_zones = [
  "us-east-2a",
  "us-east-2b"
]

container_image = "nginx:alpine"

container_cpu    = 512
container_memory = 1024

rds_instance_class = "db.t3.small"

backup_retention_period = 7

deletion_protection = true
