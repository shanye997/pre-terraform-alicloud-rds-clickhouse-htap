variable "region" {
  description = "The Alibaba Cloud region to deploy resources in"
  type        = string
  default     = "cn-hangzhou"
}

variable "name_prefix" {
  description = "The name prefix for all resources"
  type        = string
  default     = "example-htap"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vswitch_cidr_block" {
  description = "The CIDR block for the VSwitch"
  type        = string
  default     = "192.168.0.0/24"
}

variable "rds_username" {
  description = "The username for the RDS database"
  type        = string
  default     = "rds_user"
}

variable "rds_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}

variable "clickhouse_username" {
  description = "The username for the ClickHouse database"
  type        = string
  default     = "ck_user"
}

variable "clickhouse_password" {
  description = "The password for the ClickHouse database"
  type        = string
  sensitive   = true
}

variable "ecs_instance_type" {
  description = "The instance type for the ECS instance"
  type        = string
  default     = "ecs.e-c1m2.large"
}

variable "ecs_instance_password" {
  description = "The password for the ECS instance"
  type        = string
  sensitive   = true
}

variable "custom_ecs_script" {
  description = "Custom ECS command script. If not provided, the default script will be used"
  type        = string
  default     = null
}