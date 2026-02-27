
# Define local variables for large scripts
locals {
  # Default ECS command script for HTAP installation
  default_ecs_command_script = <<-EOF
    #!/bin/bash
    echo "export RDS_URL=${alicloud_db_instance.rds_instance.connection_string}" >> ~/.bash_profile
    echo "export RDS_USERNAME=${var.rds_db_account_config.account_name}" >> ~/.bash_profile
    echo "export RDS_PASSWORD=${var.rds_db_account_config.account_password}" >> ~/.bash_profile
    echo "export ROS_DEPLOY=true" >> ~/.bash_profile
    source ~/.bash_profile
    curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/rdsclickhouse-htap/install_htap.sh|sh
  EOF
}

# Create VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.vpc_config.vpc_name
  cidr_block = var.vpc_config.cidr_block
}

# Create VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  zone_id      = var.vswitch_config.zone_id
  cidr_block   = var.vswitch_config.cidr_block
  vswitch_name = var.vswitch_config.vswitch_name
}

# Create Security Group
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = var.security_group_config.security_group_name
  description         = var.security_group_config.description
}

# Create RDS Database Instance
resource "alicloud_db_instance" "rds_instance" {
  instance_name            = var.rds_instance_config.instance_name
  engine                   = var.rds_instance_config.engine
  instance_storage         = var.rds_instance_config.instance_storage
  engine_version           = var.rds_instance_config.engine_version
  category                 = var.rds_instance_config.category
  db_instance_storage_type = var.rds_instance_config.db_instance_storage_type
  security_ips             = var.rds_instance_config.security_ips
  vpc_id                   = alicloud_vpc.vpc.id
  zone_id                  = alicloud_vswitch.vswitch.zone_id
  vswitch_id               = alicloud_vswitch.vswitch.id
  instance_charge_type     = var.rds_instance_config.instance_charge_type
  instance_type            = var.rds_instance_config.instance_type
}

# Create Database
resource "alicloud_db_database" "database" {
  character_set  = var.db_database_config.character_set
  instance_id    = alicloud_db_instance.rds_instance.id
  data_base_name = var.db_database_config.name
  description    = var.db_database_config.description
}

# Create Database Account
resource "alicloud_db_account" "default" {
  db_instance_id   = alicloud_db_instance.rds_instance.id
  account_name     = var.rds_db_account_config.account_name
  account_password = var.rds_db_account_config.account_password
  account_type     = var.rds_db_account_config.account_type
}

# Create ClickHouse Database Cluster
resource "alicloud_click_house_db_cluster" "click_house" {
  db_cluster_version      = var.clickhouse_cluster_config.db_cluster_version
  category                = var.clickhouse_cluster_config.category
  db_cluster_class        = var.clickhouse_cluster_config.db_cluster_class
  db_cluster_network_type = var.clickhouse_cluster_config.db_cluster_network_type
  db_node_group_count     = var.clickhouse_cluster_config.db_node_group_count
  payment_type            = var.clickhouse_cluster_config.payment_type
  db_node_storage         = var.clickhouse_cluster_config.db_node_storage
  storage_type            = var.clickhouse_cluster_config.storage_type
  vswitch_id              = alicloud_vswitch.vswitch.id
  vpc_id                  = alicloud_vpc.vpc.id
  zone_id                 = alicloud_vswitch.vswitch.zone_id
  db_cluster_description  = var.clickhouse_cluster_config.db_cluster_description
}

# Create ClickHouse Database Account
resource "alicloud_click_house_account" "default" {
  db_cluster_id    = alicloud_click_house_db_cluster.click_house.id
  account_name     = var.clickhouse_account_config.account_name
  account_password = var.clickhouse_account_config.account_password
  type             = var.clickhouse_account_config.type
}

# Create ECS Instance
resource "alicloud_instance" "ecs_instance" {
  availability_zone          = alicloud_vswitch.vswitch.zone_id
  vpc_id                     = alicloud_vpc.vpc.id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = var.ecs_instance_config.internet_max_bandwidth_out
  security_groups            = [alicloud_security_group.security_group.id]
  password                   = var.ecs_instance_config.password
  instance_type              = var.ecs_instance_config.instance_type
  system_disk_category       = var.ecs_instance_config.system_disk_category
  image_id                   = var.ecs_instance_config.image_id
  instance_name              = var.ecs_instance_config.instance_name
}

# Create ECS Command Resource
resource "alicloud_ecs_command" "run_tpcc_alicloud_ecs_command" {
  name            = var.ecs_command_config.name
  description     = var.ecs_command_config.description
  type            = var.ecs_command_config.type
  command_content = base64encode(var.custom_ecs_command_script != null ? var.custom_ecs_command_script : local.default_ecs_command_script)
  timeout         = var.ecs_command_config.timeout
  working_dir     = var.ecs_command_config.working_dir
}

# Create ECS Command Invocation Resource
resource "alicloud_ecs_invocation" "run_tpcc_alicloud_ecs_invocation" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_tpcc_alicloud_ecs_command.id
  depends_on  = [alicloud_db_instance.rds_instance]
  timeouts {
    create = var.ecs_invocation_config.create_timeout
  }
}