locals {
  public_subnets = {
    for key , config in var.subnet_config : key => config if config.public
  }
}

data "aws_availability_zones" "availability_zone" {
  state = "available"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_config.aws_vpc_cidr

  tags = {
    Name = var.vpc_config.aws_vpc_name
  }
}

resource "aws_subnet" "public_sub" {
  for_each   = var.subnet_config
  cidr_block = each.value.aws_subnet_cidr
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = each.value.az


  lifecycle {
    precondition {
      condition = contains(data.aws_availability_zones.availability_zone.names, each.value.az)
      error_message = <<-EOT
      The AZ "${each.value.az}" provided for the subnet "${each.key}" is invalid.

      The applied AWS region "${data.aws_availability_zones.availability_zone.id}" supports the following AZs:
      [${join(", ", data.aws_availability_zones.availability_zone.names)}]
      EOT
    }
  }
}

resource "aws_internet_gateway" "this" {
  count = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_rtb" {
  count = length(local.public_subnets) > 0 ? 1 :0
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }
  vpc_id = aws_vpc.my_vpc.id
}


resource "aws_route_table_association" "public" {
  for_each = local.public_subnets
  subnet_id = aws_subnet.public_sub[each.key].id
  route_table_id = aws_route_table.public_rtb[0].id
}





