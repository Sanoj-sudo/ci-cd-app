
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "cluster_name" {
  type    = string
  default = "dev-eks-cluster"
}

variable "kubernetes_version" {
  type    = string
  default = "1.33"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

variable "public_subnet_cidrs" {
  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidrs" {
  type = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}


variable "iam_user_arns" {
  description = "List of IAM users requiring EKS cluster admin access"
  type        = list(string)
  default     = []
}

variable "github_actions_role_arns" {
  description = "List of GitHub Actions IAM roles requiring EKS cluster admin access"
  type        = list(string)
  default     = []
}

variable "root_account_id" {
  description = "AWS account ID for root admin role"
  type        = string
}
