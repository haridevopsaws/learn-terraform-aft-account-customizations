variable "custom_fields" {
  type = map(string)

  default = {
    create_vpc = "false"
  }
}

locals {
  create_vpc = lookup(var.custom_fields, "create_vpc", "false") == "true"
}

resource "aws_vpc" "main" {
  count = local.create_vpc ? 1 : 0

  cidr_block = "172.31.0.0/16"

  tags = {
    Name = "sandbox-vpc"
  }
}
