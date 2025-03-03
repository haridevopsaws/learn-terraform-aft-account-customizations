variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "environment" {
  description = "environment name"
  type        = string
}

variable "dhcp_domain_name" {
  description = "DHCP option-set domain name"
  type        = string
}

variable "dhcp_domain_name_servers" {
  description = "DHCP option-set domain name servers"
  type        = list(string)
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS support in VPC"
  type        = bool
}

# variable "transit_gateway_id" {
#   description = "trasit gateway ID"
#   type        = string
# }

variable "region" {
  description = "region name"
  type = string
}

variable "vpc_name" {
  description = "vpc name"
  type = string
}

variable "resolver_rule_ids" {
  description = "List of Route 53 resolver rule IDs to associate with the VPC"
  type        = list(string)
}

variable "subnets" {
  description = "Private subnet details"
  type = map(object({
    subnet_name = string
    subnet_cidr_range = string
    subnet_availability_zone = string
  }))
}
