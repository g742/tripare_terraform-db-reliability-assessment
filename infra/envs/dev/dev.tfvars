aws_region = "us-east-2"

environment = "dev"

vpc_cidr = "10.10.0.0/16"

availability_zones = [
  "us-east-2a",
  "us-east-2b"
]

container_image = "nginx:alpine"

container_cpu    = 256
container_memory = 512

rds_instance_class = "db.t3.micro"

backup_retention_period = 1

deletion_protection = false
