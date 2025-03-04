resource "aws_vpc" "new_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_vpc_dhcp_options" "new_dhcp" {
  domain_name         = var.dhcp_domain_name
  domain_name_servers = var.dhcp_domain_name_servers

  tags = {
    Name = "${var.vpc_name}-DHCP-Options-Set"
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_assocication" {
  vpc_id          = aws_vpc.new_vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.new_dhcp.id
}

resource "aws_route53_resolver_rule_association" "this" {
  for_each = toset(var.resolver_rule_ids)

  resolver_rule_id = each.value
  vpc_id           = aws_vpc.new_vpc.id
}

resource "aws_subnet" "private_subnet" {
  for_each = var.subnets

  vpc_id     = aws_vpc.new_vpc.id
  cidr_block = each.value.subnet_cidr_range
  availability_zone = each.value.subnet_availability_zone

  tags = {
    Name = each.value.subnet_name
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.new_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id          = "aws_nat_gateway"
    # transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "${var.vpc_name}-Route-Table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  for_each = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}


# resource "aws_ec2_transit_gateway_vpc_attachment" "new_tgw_attachment" {
#   subnet_ids         = slice([for subnet in aws_subnet.private_subnet : subnet.id], 0, 2)
#   transit_gateway_id = var.transit_gateway_id
#   vpc_id             = aws_vpc.new_vpc.id

#   tags = {
#     Name = "${var.vpc_name}-TGW-Attachment"
#   }
# }

resource "aws_flow_log" "vpc_flow_logs" {
  vpc_id          = aws_vpc.new_vpc.id
  log_destination = "arn:aws:s3:::aws-all-vpc-logs-276926722005-us-east-1"
  log_destination_type = "s3"
  traffic_type    = "ALL"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.new_vpc.id
  service_name = "com.amazonaws.us-east-1.s3"

  route_table_ids = aws_route_table.private_route_table[*].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "*"
      Resource  = "*"
    }]
  })
}
