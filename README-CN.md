阿里云 RDS ClickHouse HTAP 解决方案 Terraform 模块

================================================ 

# terraform-alicloud-rds-clickhouse-htap

[English](https://github.com/alibabacloud-automation/terraform-alicloud-rds-clickhouse-htap/blob/main/README.md) | 简体中文

在阿里云上创建完整的 HTAP（混合事务/分析处理）解决方案的 Terraform 模块，使用 RDS MySQL 和 ClickHouse。该模块实现了[RDS 与 ClickHouse 构建一站式 HTAP](https://www.aliyun.com/solution/tech-solution/rdsclickhouse-htap)解决方案，涉及专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、RDS 数据库（RDS）、ClickHouse 数据库（ClickHouse）等资源的创建和部署。

## 使用方法

此模块创建完整的 HTAP 基础设施，包括 VPC、用于事务处理的 RDS MySQL、用于分析处理的 ClickHouse，以及用于应用程序部署的 ECS，并提供自动化安装脚本。

```terraform
module "rds_clickhouse_htap" {
  source = "alibabacloud-automation/rds-clickhouse-htap/alicloud"

  # 通用配置
  common_config = {
    name_prefix = "my-htap-solution"
  }

  # 数据库实例规格
  database_instance_class = "8C32G"

  # VPC 配置
  vpc_config = {
    cidr_block = "192.168.0.0/16"
    vpc_name   = "htap-vpc"
  }

  # 交换机配置
  vswitch_config = {
    cidr_block   = "192.168.0.0/24"
    zone_index   = 1
    vswitch_name = "htap-vswitch"
  }

  # RDS 账号配置
  rds_db_account_config = {
    account_name     = "rds_user"
    account_password = "YourRdsPassword123!"
    account_type     = "Super"
  }

  # ClickHouse 账号配置
  clickhouse_account_config = {
    account_name     = "ck_user"
    account_password = "YourClickHousePassword123!"
    type             = "Super"
  }

  # ECS 实例配置
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

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-rds-clickhouse-htap/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)