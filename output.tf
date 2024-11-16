output "public_subnets" {
  value = {
    for key,  config in (var.subnet_config) : "subnet details" => {az = config.az,aws_subnet_cidr = config.aws_subnet_cidr} if config.public == true
  }
}

output "private_subnets" {
  value = {
    for key,  config in (var.subnet_config) : "subnet details" => {az = config.az,aws_subnet_cidr = config.aws_subnet_cidr} if config.public == false
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "private_subnet_id" {
  value = aws_subnet.public_sub["sub_1"].id
}

output "public_subnet_id" {
  value = aws_subnet.public_sub["sub_2"].id
}


