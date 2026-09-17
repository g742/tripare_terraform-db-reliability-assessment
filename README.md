# Terraform + Database Reliability Assessment

## Architecture

Internet
   |
  ALB
   |
ECS/Fargate
   |
  RDS PostgreSQL

## Repository Structure

infra/
  modules/
    network/
    ecs/
    rds/
  envs/
    dev/
    prod/

database/
  migrations/
  seed/

scripts/
  backup.sh
  restore.sh

docker-compose.yml

.github/workflows/terraform.yml

## Terraform Validation

### Dev

cd infra/envs/dev

terraform init
terraform fmt -recursive
terraform validate
terraform plan -refresh=false -var-file=dev.tfvars

### Prod

cd infra/envs/prod

terraform init
terraform fmt -recursive
terraform validate
terraform plan -refresh=false -var-file=prod.tfvars

No AWS resources are deployed.

## Database

Start PostgreSQL:

docker compose up -d

Verify:

docker compose ps

Connect:

docker exec -it hotel-postgres \
psql -U hotel_user -d hotel_db

## Seed Data

SELECT COUNT(*) FROM hotel_bookings;

SELECT city, COUNT(*)
FROM hotel_bookings
GROUP BY city;

SELECT status, COUNT(*)
FROM hotel_bookings
GROUP BY status;

## Query Optimization

The query filters by city and created_at.

Index:

CREATE INDEX idx_hotel_bookings_city_created_at
ON hotel_bookings(city, created_at);

EXPLAIN ANALYZE is used to inspect the query plan.

## Backup

./scripts/backup.sh

Backups are stored in:

backups/

## Restore

./scripts/restore.sh backups/<backup-file>.dump

The restore creates a fresh database called hotel_restore.

Verify:

SELECT COUNT(*) FROM hotel_bookings;

SELECT COUNT(*) FROM booking_events;

## Environment Differences

| Setting | Dev | Prod |
|---|---|---|
| ECS CPU | 256 | 512 |
| ECS Memory | 512 MB | 1024 MB |
| RDS | db.t3.micro | db.t3.small |
| Backup retention | 1 day | 7 days |
| Deletion protection | false | true |

## AWS Deployment

AWS deployment is intentionally not performed.
Terraform is validated using fmt, init, validate and plan.
