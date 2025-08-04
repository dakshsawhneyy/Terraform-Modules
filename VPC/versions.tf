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
    }
}
