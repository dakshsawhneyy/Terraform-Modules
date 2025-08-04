# =============================================================================
# TERRAFORM AND PROVIDER VERSIONS
# =============================================================================

terraform {
    required_version = ">= 1.0"

    required_providers {
      # AWS
      aws = {
        source  = "hashicorp/aws"
        version = ">= 5.0"
      }
      random = {
        source  = "hashicorp/random"
        version = ">= 3.0"
      }
      kubernetes = {
        source  = "hashicorp/kubernetes"
        version = ">= 2.0"
      }
      helm = {
        source  = "hashicorp/helm"
        version = ">= 2.0"
      }
    }
}

# =============================================================================
# PROVIDER CONFIGURATIONS
# =============================================================================

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}
