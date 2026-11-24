
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "cluster_role_arn" {
  description = "EKS cluster IAM role"
  type        = string
}

variable "subnet_ids" {
  description = "EKS subnet IDs"
  type        = list(string)
}

variable "iam_user_arns" {
  description = "Multiple IAM user ARNs"
  type        = list(string)
  default     = []
}

variable "github_actions_role_arns" {
  description = "Multiple GitHub Actions role ARNs"
  type        = list(string)
  default     = []
}

variable "root_admin_role_arn" {
  description = "AWS root assumed role ARN"
  type        = string
}
