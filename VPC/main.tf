# =============================================================
# Creating VPC
# =============================================================

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  # Nat Gateway Configuration
  enable_nat_gateway = true
  single_nat_gateway = var.enable_single_nat_gateway

  # Internet Gateway
  create_igw = true

  # DNS Configuration
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Manage default resources for better control
  # NACL
  manage_default_network_acl = true
  default_network_acl_tags = { Name = "${var.cluster_name}-default-nacl" }
  # ROUTE TABLE
  manage_default_route_table    = true
  default_route_table_tags      = { Name = "${var.cluster_name}-default-rt" }
  # SECURITY GROUP
  manage_default_security_group = true
  default_security_group_tags   = { Name = "${var.cluster_name}-default-sg" }

  tags = local.common_tags
}
