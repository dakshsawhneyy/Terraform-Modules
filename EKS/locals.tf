# Data Sources
# This fetches all the availability zones present in your current region
data "aws_availability_zones" "available" {
  state = "available"
}

# Returns metadata about your current AWS identity (used for tagging).
data "aws_caller_identity" "current" {}

# Random suffix for unique resource names
resource "random_string" "suffix" {
  length = 4
  special = false
  upper = false
}


# Local computed values
locals {
  cluster_name = "${var.cluster_name}-${random_string.suffix.result}"

  # network configuration
  azs = slice(data.aws_availability_zones.available.names, 0, 3)  # Takes the first 3 AZs from the available list.
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 10)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]

  # Common tags applied to all resources
  common_tags = {
    Environment = var.environment
    Project = "daksh-retail-store"
    ManagedBy = "terraform"
    CreatedBy = "Daksh Sawhney"
    Owner         = data.aws_caller_identity.current.user_id
    CreatedDate   = formatdate("YYYY-MM-DD", timestamp())
  }

  # Kubernetes subnet tags -- required for making load balancers
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
  
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
