locals {
  create_vpc = var.custom_fields["create_vpc"] == "true"
}

resource "aws_vpc" "main" {
  count = local.create_vpc ? 1 : 0

  cidr_block = "172.31.0.0/16"
tags = {
    Name = "sandbox-vpc"
  }
}
