# Complete Example

This example demonstrates how to use the RDS ClickHouse HTAP module to create a complete HTAP (Hybrid Transactional/Analytical Processing) solution.

## Overview

This example creates:
- A VPC with a VSwitch in the specified availability zone
- A security group for network access control
- An RDS MySQL instance for transactional processing
- A ClickHouse cluster for analytical processing
- An ECS instance for application deployment
- ECS commands for automated HTAP installation

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur costs. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.212.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds_clickhouse_htap"></a> [rds\_clickhouse\_htap](#module\_rds\_clickhouse\_htap) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_zones.available](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clickhouse_password"></a> [clickhouse\_password](#input\_clickhouse\_password) | The password for the ClickHouse database | `string` | n/a | yes |
| <a name="input_ecs_password"></a> [ecs\_password](#input\_ecs\_password) | The password for the ECS instance | `string` | n/a | yes |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | The password for the RDS database | `string` | n/a | yes |
| <a name="input_clickhouse_username"></a> [clickhouse\_username](#input\_clickhouse\_username) | The username for the ClickHouse database | `string` | `"ck_user"` | no |
| <a name="input_custom_ecs_script"></a> [custom\_ecs\_script](#input\_custom\_ecs\_script) | Custom ECS command script. If not provided, the default script will be used | `string` | `null` | no |
| <a name="input_database_instance_class"></a> [database\_instance\_class](#input\_database\_instance\_class) | Database instance class specification. Valid values: 8C32G, 16C64G, 32C128G, 64C256G | `string` | `"8C32G"` | no |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | The instance type for the ECS instance | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The name prefix for all resources | `string` | `"example-htap"` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | The username for the RDS database | `string` | `"rds_user"` | no |
| <a name="input_region"></a> [region](#input\_region) | The Alibaba Cloud region to deploy resources in | `string` | `"cn-hangzhou"` | no |
| <a name="input_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#input\_vswitch\_cidr\_block) | The CIDR block for the VSwitch | `string` | `"192.168.0.0/24"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC | `string` | `"192.168.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_clickhouse_cluster_connection_string"></a> [clickhouse\_cluster\_connection\_string](#output\_clickhouse\_cluster\_connection\_string) | The connection string of the ClickHouse cluster |
| <a name="output_clickhouse_cluster_id"></a> [clickhouse\_cluster\_id](#output\_clickhouse\_cluster\_id) | The ID of the ClickHouse cluster |
| <a name="output_common_name"></a> [common\_name](#output\_common\_name) | The common name prefix used for resources |
| <a name="output_ecs_instance_id"></a> [ecs\_instance\_id](#output\_ecs\_instance\_id) | The ID of the ECS instance |
| <a name="output_ecs_instance_private_ip"></a> [ecs\_instance\_private\_ip](#output\_ecs\_instance\_private\_ip) | The private IP address of the ECS instance |
| <a name="output_ecs_instance_public_ip"></a> [ecs\_instance\_public\_ip](#output\_ecs\_instance\_public\_ip) | The public IP address of the ECS instance |
| <a name="output_rds_instance_connection_string"></a> [rds\_instance\_connection\_string](#output\_rds\_instance\_connection\_string) | The connection string of the RDS instance |
| <a name="output_rds_instance_id"></a> [rds\_instance\_id](#output\_rds\_instance\_id) | The ID of the RDS instance |
| <a name="output_region"></a> [region](#output\_region) | The current region |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |

## Important Notes

1. **Passwords**: You must provide strong passwords for the RDS, ClickHouse, and ECS instances. The passwords must be 8-30 characters long and contain at least three of the following: uppercase letters, lowercase letters, numbers, and special characters (!@#$%^&*()_+-=).

2. **Instance Classes**: The `database_instance_class` variable controls the specifications of both RDS and ClickHouse instances. Valid values are: 8C32G, 16C64G, 32C128G, 64C256G.

3. **Custom Script**: You can optionally provide a custom ECS command script via the `custom_ecs_script` variable. If not provided, the default HTAP installation script will be used.

4. **Region**: Make sure to choose a region that supports all the required services (RDS MySQL, ClickHouse, ECS).

## Example Usage

```bash
# Set required variables
export TF_VAR_rds_password="YourRdsPassword123!"
export TF_VAR_clickhouse_password="YourClickHousePassword123!"
export TF_VAR_ecs_password="YourEcsPassword123!"

# Initialize and apply
terraform init
terraform plan
terraform apply
```