module "vpc" {
  source = "./modules/network"
  vpc_config = {
    aws_vpc_cidr = "10.50.0.0/16"
    aws_vpc_name = "Terraform-Vpc"
  }

  subnet_config = {
    sub_1 = {
      aws_subnet_cidr = "10.50.1.0/24"
      az              = "ap-south-1a"
    },
    sub_2 = {
      aws_subnet_cidr = "10.50.2.0/24"
      az              = "ap-south-1b"
      # Public subnets are indicated by setting the "public" as true
      public          = true
    }
  }

}


