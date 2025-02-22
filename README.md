# Networking Module

This module manages the creation of the VPCs and subnets , allowing for the creation of both private and public subnets.

Example usage:
```
module "vpc" {
  source = "./modules/network"
  vpc_config = {
    aws_vpc_cidr = "10.0.0.0/16"
    aws_vpc_name = "Terraform-Vpc"
  }

  subnet_config = {
    sub_1 = {
      aws_subnet_cidr = "10.0.1.0/24"
      az              = "ap-south-1a"
    },
    sub_2 = {
      aws_subnet_cidr = "10.0.2.0/24"
      az              = "ap-south-1b"
      public          = true
    }
  }

}

```