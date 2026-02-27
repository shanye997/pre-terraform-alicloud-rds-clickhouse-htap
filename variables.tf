
variable "vpc_config" {
  description = "The parameters of VPC. The attributes 'cidr_block' and 'vpc_name' are required."
  type = object({
    cidr_block = string
    vpc_name   = string
  })
}

variable "vswitch_config" {
  description = "The parameters of VSwitch. The attributes 'cidr_block', 'zone_id', and 'vswitch_name' are required."
  type = object({
    cidr_block   = string
    zone_id      = string
    vswitch_name = string
  })
  # No default value - zone_id is immutable and must be explicitly provided
}

variable "security_group_config" {
  description = "The parameters of security group."
  type = object({
    security_group_name = optional(string, "security-group")
    description         = optional(string, "Security group for RDS ClickHouse HTAP solution")
  })
  default = {}
}

variable "rds_instance_config" {
  description = "The parameters of RDS instance. The attributes 'engine', 'engine_version', 'instance_storage', 'category', 'db_instance_storage_type', 'instance_charge_type', 'instance_type', and 'instance_name' are required."
  type = object({
    engine                   = string
    engine_version           = string
    instance_storage         = number
    category                 = string
    db_instance_storage_type = string
    instance_charge_type     = string
    security_ips             = list(string)
    instance_type            = string
    instance_name            = string
  })
  default = {
    engine                   = "MySQL"
    engine_version           = "8.0"
    instance_storage         = 100
    category                 = "HighAvailability"
    db_instance_storage_type = "cloud_essd"
    instance_charge_type     = "PostPaid"
    security_ips             = ["0.0.0.0/0"]
    instance_type            = "mysql.x4.xlarge.2c"
    instance_name            = "rdsmysql"
  }
}

variable "db_database_config" {
  description = "The parameters of database. The attributes 'character_set', 'name', 'description' are required."
  type = object({
    character_set = string
    name          = string
    description   = string
  })
  default = {
    character_set = "utf8mb4"
    name          = "tpcc"
    description   = "tpcc"
  }
}

variable "rds_db_account_config" {
  description = "The parameters of RDS database account. The attributes 'account_name', 'account_password', 'account_type' are required."
  type = object({
    account_name     = string
    account_password = string
    account_type     = string
  })
  default = {
    account_name     = "rds_user"
    account_password = null
    account_type     = "Super"
  }
}

variable "clickhouse_cluster_config" {
  description = "The parameters of ClickHouse cluster. The attributes 'db_cluster_version', 'category', 'db_cluster_class', 'db_cluster_network_type', 'db_node_group_count', 'payment_type', 'db_node_storage', 'storage_type', and 'db_cluster_description' are required."
  type = object({
    db_cluster_version      = string
    category                = string
    db_cluster_class        = string
    db_cluster_network_type = string
    db_node_group_count     = string
    payment_type            = string
    db_node_storage         = string
    storage_type            = string
    db_cluster_description  = string
  })
  default = {
    db_cluster_version      = "23.8"
    category                = "Basic"
    db_cluster_class        = "S8"
    db_cluster_network_type = "vpc"
    db_node_group_count     = "1"
    payment_type            = "PayAsYouGo"
    db_node_storage         = "100"
    storage_type            = "cloud_essd"
    db_cluster_description  = "ck"
  }
}

variable "clickhouse_account_config" {
  description = "The parameters of ClickHouse account. The attributes 'account_name', 'account_password', 'type' are required."
  type = object({
    account_name     = string
    account_password = string
    type             = string
  })
  default = {
    account_name     = "ck_user"
    account_password = null
    type             = "Super"
  }
}

variable "ecs_instance_config" {
  description = "The parameters of ECS instance. The attributes 'instance_type', 'password', 'system_disk_category', 'internet_max_bandwidth_out', 'image_id', and 'instance_name' are required."
  type = object({
    instance_type              = string
    password                   = string
    system_disk_category       = string
    internet_max_bandwidth_out = number
    image_id                   = string
    instance_name              = string
  })
  default = {
    instance_type              = "ecs.e-c1m2.large"
    password                   = null
    system_disk_category       = "cloud_essd"
    internet_max_bandwidth_out = 5
    image_id                   = null
    instance_name              = "ecs-instance"
  }
}

variable "ecs_command_config" {
  description = "The parameters of ECS command. The attributes 'name', 'description', 'type', 'timeout', 'working_dir' are required."
  type = object({
    name        = string
    description = string
    type        = string
    timeout     = number
    working_dir = string
  })
  default = {
    name        = "commond_install"
    description = "commond_install_description"
    type        = "RunShellScript"
    timeout     = 1800 # Reduced from 3600 to 1800 seconds (30 minutes)
    working_dir = "/root"
  }
}

variable "ecs_invocation_config" {
  description = "The parameters of ECS invocation. The attribute 'create_timeout' is required."
  type = object({
    create_timeout = string
  })
  default = {
    create_timeout = "30m" # Reduced from 60m to 30m
  }
}

variable "custom_ecs_command_script" {
  description = "Custom ECS command script for HTAP installation. If not provided, the default script will be used."
  type        = string
  default     = null
}