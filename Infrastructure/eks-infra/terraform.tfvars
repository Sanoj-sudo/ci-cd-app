
aws_region = "ap-south-1"

cluster_name = "dev-eks-cluster"

kubernetes_version = "1.33"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

instance_types = ["t3.medium"]


# =========================================
# AWS ACCOUNT ROOT
# =========================================

root_account_id = "636710162452"


# =========================================
# MULTIPLE IAM USERS
# =========================================

iam_user_arns = [
  "arn:aws:iam::123456789012:user/sanoj",
  "arn:aws:iam::123456789012:user/adity"
]


# =========================================
# MULTIPLE GITHUB ACTIONS ROLES
# =========================================

github_actions_role_arns = [
  "arn:aws:iam::636710162452:role/github_actions"
]
