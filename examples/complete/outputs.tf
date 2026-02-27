# Module outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.rds_clickhouse_htap.vpc_id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = module.rds_clickhouse_htap.vswitch_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.rds_clickhouse_htap.security_group_id
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = module.rds_clickhouse_htap.rds_instance_id
}

output "rds_instance_connection_string" {
  description = "The connection string of the RDS instance"
  value       = module.rds_clickhouse_htap.rds_instance_connection_string
}

output "clickhouse_cluster_id" {
  description = "The ID of the ClickHouse cluster"
  value       = module.rds_clickhouse_htap.clickhouse_cluster_id
}

output "clickhouse_cluster_connection_string" {
  description = "The connection string of the ClickHouse cluster"
  value       = module.rds_clickhouse_htap.clickhouse_cluster_connection_string
}

output "ecs_instance_id" {
  description = "The ID of the ECS instance"
  value       = module.rds_clickhouse_htap.ecs_instance_id
}

output "ecs_instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = module.rds_clickhouse_htap.ecs_instance_public_ip
}

output "ecs_instance_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = module.rds_clickhouse_htap.ecs_instance_private_ip
}