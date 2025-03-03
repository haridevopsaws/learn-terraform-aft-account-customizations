module "vpc" {
  source = "../modules/vpc_creation"

  environment              = var.environment
  vpc_cidr                 = var.vpc_cidr
  enable_dns_hostnames     = var.enable_dns_hostnames
  enable_dns_support       = var.enable_dns_support
  #transit_gateway_id       = var.transit_gateway_id
  subnets                  = var.subnets
  region                   = var.region
  vpc_name                 = var.vpc_name
  resolver_rule_ids        = var.resolver_rule_ids
  dhcp_domain_name         = var.dhcp_domain_name
  dhcp_domain_name_servers = var.dhcp_domain_name_servers   
}
