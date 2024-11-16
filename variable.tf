variable "vpc_config" {
  type = object({
    aws_vpc_cidr = string
    aws_vpc_name = string
  })
  validation {
    condition     = can(cidrnetmask(var.vpc_config.aws_vpc_cidr))
    error_message = "Should be valid cidr range"
  }
  sensitive = true

}


variable "subnet_config" {
  type = map(object({
    aws_subnet_cidr = string
    az = string
    public = optional(bool,false)
  }))
  validation {
    condition     = alltrue([ for config in values(var.subnet_config) : can(cidrnetmask(config.aws_subnet_cidr))])
    error_message = "Should be valid cidr range"
  }
}
