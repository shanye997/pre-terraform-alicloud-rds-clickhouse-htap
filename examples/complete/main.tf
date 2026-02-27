provider "alicloud" {
  region = var.region
}

# Get available zones for database instances
data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# Get latest CentOS 7.9 image
data "alicloud_images" "centos" {
  name_regex  = "^centos_7_9_x64_*"
  owners      = "system"
  most_recent = true
}

# Call the RDS ClickHouse HTAP module
module "rds_clickhouse_htap" {
  source = "../../"

  # VPC configuration
  vpc_config = {
    cidr_block = var.vpc_cidr_block
    vpc_name   = "${var.name_prefix}-vpc"
  }

  # VSwitch configuration
  vswitch_config = {
    cidr_block   = var.vswitch_cidr_block
    zone_id      = data.alicloud_db_zones.default.ids[1]
    vswitch_name = "${var.name_prefix}-vswitch"
  }

  # Security group configuration
  security_group_config = {
    security_group_name = "${var.name_prefix}-sg"
    description         = "Security group for RDS ClickHouse HTAP solution"
  }

  # RDS instance configuration
  rds_instance_config = {
    engine                   = "MySQL"
    engine_version           = "8.0"
    instance_storage         = 100
    category                 = "HighAvailability"
    db_instance_storage_type = "cloud_essd"
    instance_charge_type     = "Postpaid"
    security_ips             = ["0.0.0.0/0"]
    instance_type            = "mysql.x4.xlarge.2c"
    instance_name            = "${var.name_prefix}-rds"
  }

  # Database configuration
  db_database_config = {
    character_set = "utf8mb4"
    name          = "tpcc"
    description   = "tpcc"
  }

  # RDS account configuration
  rds_db_account_config = {
    account_name     = var.rds_username
    account_password = var.rds_password
    account_type     = "Super"
  }

  # ClickHouse cluster configuration
  clickhouse_cluster_config = {
    db_cluster_version      = "23.8"
    category                = "Basic"
    db_cluster_class        = "S8"
    db_cluster_network_type = "vpc"
    db_node_group_count     = "1"
    payment_type            = "PayAsYouGo"
    db_node_storage         = "100"
    storage_type            = "cloud_essd"
    db_cluster_description  = "${var.name_prefix}-ck"
  }

  # ClickHouse account configuration
  clickhouse_account_config = {
    account_name     = var.clickhouse_username
    account_password = var.clickhouse_password
    type             = "Super"
  }

  # ECS instance configuration
  ecs_instance_config = {
    instance_type              = var.ecs_instance_type
    password                   = var.ecs_instance_password
    system_disk_category       = "cloud_essd"
    internet_max_bandwidth_out = 5
    image_id                   = data.alicloud_images.centos.images[0].id
    instance_name              = "${var.name_prefix}-ecs"
  }

  # ECS command configuration
  ecs_command_config = {
    name        = "install_htap"
    description = "Install HTAP components"
    type        = "RunShellScript"
    timeout     = 1800 # 30 minutes timeout
    working_dir = "/root"
  }

  # ECS invocation configuration
  ecs_invocation_config = {
    create_timeout = "30m" # 30 minutes timeout
  }

  # Custom ECS command script (optional)
  custom_ecs_command_script = var.custom_ecs_script
}