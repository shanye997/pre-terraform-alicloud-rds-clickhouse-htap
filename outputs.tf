# VPC outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = alicloud_vpc.vpc.cidr_block
}

# VSwitch outputs
output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.vswitch.id
}

output "vswitch_cidr_block" {
  description = "The CIDR block of the VSwitch"
  value       = alicloud_vswitch.vswitch.cidr_block
}

output "vswitch_zone_id" {
  description = "The zone ID of the VSwitch"
  value       = alicloud_vswitch.vswitch.zone_id
}

# Security Group outputs
output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.security_group.id
}

# RDS outputs
output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = alicloud_db_instance.rds_instance.id
}

output "rds_instance_connection_string" {
  description = "The connection string of the RDS instance"
  value       = alicloud_db_instance.rds_instance.connection_string
}

output "rds_instance_port" {
  description = "The port of the RDS instance"
  value       = alicloud_db_instance.rds_instance.port
}

output "rds_database_name" {
  description = "The name of the RDS database"
  value       = alicloud_db_database.database.data_base_name
}

output "rds_account_name" {
  description = "The name of the RDS database account"
  value       = alicloud_db_account.default.account_name
}

# ClickHouse outputs
output "clickhouse_cluster_id" {
  description = "The ID of the ClickHouse cluster"
  value       = alicloud_click_house_db_cluster.click_house.id
}

output "clickhouse_cluster_connection_string" {
  description = "The connection string of the ClickHouse cluster"
  value       = alicloud_click_house_db_cluster.click_house.connection_string
}

output "clickhouse_cluster_port" {
  description = "The port of the ClickHouse cluster"
  value       = alicloud_click_house_db_cluster.click_house.port
}

output "clickhouse_account_name" {
  description = "The name of the ClickHouse account"
  value       = alicloud_click_house_account.default.account_name
}

# ECS outputs
output "ecs_instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.ecs_instance.id
}

output "ecs_instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.public_ip
}

output "ecs_instance_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.private_ip
}

# ECS Command outputs
output "ecs_command_id" {
  description = "The ID of the ECS command"
  value       = alicloud_ecs_command.run_tpcc_alicloud_ecs_command.id
}

output "ecs_invocation_id" {
  description = "The ID of the ECS command invocation"
  value       = alicloud_ecs_invocation.run_tpcc_alicloud_ecs_invocation.id
}


# Sensitive outputs
output "rds_account_password" {
  description = "The password of the RDS database account"
  value       = var.rds_db_account_config.account_password
  sensitive   = true
}

output "clickhouse_account_password" {
  description = "The password of the ClickHouse account"
  value       = var.clickhouse_account_config.account_password
  sensitive   = true
}

output "ecs_instance_password" {
  description = "The password of the ECS instance"
  value       = var.ecs_instance_config.password
  sensitive   = true
}