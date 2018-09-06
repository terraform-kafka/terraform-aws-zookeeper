# Terraform Module: AWS Zookeeper

> This repository is a [Terraform](https://terraform.io/) Module to use create zookeeper cluster.

## Table of Contents

- [Requirements](#requirements)
- [Usage](#usage)
  - [Module Variables](#module-variables)
  - [Module Outputs](#module-variables)
- [Maintainers](#maintainers)

## Requirements

This module requires Terraform version `0.10.x` or newer.

## Usage

Add the module to your Terraform resources:

```hcl
module "zookeeper-subnets" {
  source      = "github.com/terraform-kafka/terraform-aws-multi-az-subnets?ref=v0.0.1"
  name        = "broker-zookeeper-group"
  vpc_id      = "vpc-2f09a348"
  cidr_blocks = [
    "172.20.132.0/27",
    "172.20.132.32/27",
    "172.20.132.64/27",
  ]
}

module "zookeeper-cluster" {
  source      = "github.com/terraform-kafka/terraform-aws-zookeeper?ref=v0.0.1"
  name        = "zk"
  count       = 3
  subnet_ids  = "${module.zookeeper-subnets.subnet_ids}"
  subnet_cidr = "${module.zookeeper-subnets.subnet_cidr}"
  ami         = "some-ami-id"
}
```

Load the module using `terraform get` and apply using `terraform apply`.

### Module Variables

Available variables are listed below, along with their default values:

| variable                  | description                                                    |
|---------------------------|----------------------------------------------------------------|
| `name`                    | The prefix name for zookeeper server.                          |
| `count`                   | The size of the zookeeper cluster.                             |
| `subnet_ids`              | List of subnet ids where launch zookeeper.                     |
| `subnet_cidr`             | List of subnet cidr (same order as sub ids.                    |
| `ami`                     | The AMI to use for the instance.                               |
| `ebs_optimized`           | Optimized configuration dedicated capacity for Amazon EBS I/O. |
| `disable_api_termination` | Termination Protection for an Instance.                        |
| `monitoring`              | Enable detailed monitoring.                                    |
| `tags`                    | Extra tags to add on the created resources.                    |


### Module Outputs

Available outputs are listed below, along with their description:

| output         | description                 |
|----------------|-----------------------------|
| `subnet_ids`   | List of created subnet ids  |
| `subnet_cidr`  | List of created subnet cidr |

## Maintainers

This module is currently maintained by the individuals listed below.

- [Bryan Frimin](https://github.com/gearnode)
