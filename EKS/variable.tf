variable "aws_region" {
    description = "AWS Region will be created"
    type = string
    default = "ap-south-1"
}

variable "cluster_name" {
    description = "Cluster Name"
    type = string
    default = "daksh-retail-store"
}

variable "vpc_cidr" {
    description = "CIDR BLOCK"
    type = string
    default = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.33"
}

variable "enable_single_nat_gateway" {
  description = "Use single NAT gateway to reduce costs (not recommended for production)"
  type        = bool
  default     = true
}
