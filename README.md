Alibaba Cloud RDS ClickHouse HTAP Solution Terraform Module

================================================ 

# terraform-alicloud-rds-clickhouse-htap

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-rds-clickhouse-htap/blob/main/README-CN.md)

Terraform module which creates a complete HTAP (Hybrid Transactional/Analytical Processing) solution using RDS MySQL and ClickHouse on Alibaba Cloud. This module implements the [RDS and ClickHouse enable an all-in-one HTAP solution](https://www.aliyun.com/solution/tech-solution/rdsclickhouse-htap), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Elastic Compute Service (ECS), RDS Database (RDS), ClickHouse Database (ClickHouse).

## Usage

This module creates a complete HTAP infrastructure including VPC, RDS MySQL for transactional processing, ClickHouse for analytical processing, and ECS for application deployment with automated installation scripts.

```terraform
module "rds_clickhouse_htap" {
  source = "alibabacloud-automation/rds-clickhouse-htap/alicloud"

  # Common configuration
  common_config = {
    name_prefix = "my-htap-solution"
  }

  # Database instance class
  database_instance_class = "8C32G"

  # VPC configuration
  vpc_config = {
    cidr_block = "192.168.0.0/16"
    vpc_name   = "htap-vpc"
  }

  # VSwitch configuration
  vswitch_config = {
    cidr_block   = "192.168.0.0/24"
    zone_index   = 1
    vswitch_name = "htap-vswitch"
  }

  # RDS account configuration
  rds_db_account_config = {
    account_name     = "rds_user"
    account_password = "YourRdsPassword123!"
    account_type     = "Super"
  }

  # ClickHouse account configuration
  clickhouse_account_config = {
    account_name     = "ck_user"
    account_password = "YourClickHousePassword123!"
    type             = "Super"
  }

  # ECS instance configuration
  ecs_instance_config = {
    instance_type              = "ecs.e-c1m2.large"
    password                   = "YourEcsPassword123!"
    system_disk_category       = "cloud_essd"
    internet_max_bandwidth_out = 5
    instance_name              = "htap-ecs"
    image_name_regex           = "^centos_7_9_x64_*"
    image_owners               = "system"
    image_most_recent          = true
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-rds-clickhouse-htap/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)