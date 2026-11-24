
# =========================================
# VPC MODULE
# =========================================

module "vpc" {
  source = "../modules/vpc"

  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  cluster_name         = var.cluster_name
}


# =========================================
# IAM MODULE
# =========================================

module "iam" {
  source = "../modules/iam"

  cluster_name    = var.cluster_name
  root_account_id = var.root_account_id
}


# =========================================
# EKS MODULE
# =========================================

module "eks" {
  source = "../modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  cluster_role_arn = module.iam.cluster_role_arn

  subnet_ids = concat(
    module.vpc.public_subnet_ids,
    module.vpc.private_subnet_ids
  )

  # Multiple IAM users
  iam_user_arns = var.iam_user_arns

  # Multiple GitHub Actions roles
  github_actions_role_arns = var.github_actions_role_arns

  # Root admin role
  root_admin_role_arn = module.iam.root_admin_role_arn

  depends_on = [
    module.iam,
    module.vpc
  ]
}


# =========================================
# NODE GROUP MODULE
# =========================================

module "node_group" {
  source = "../modules/node-group"

  cluster_name   = module.eks.cluster_name
  node_role_arn  = module.iam.node_role_arn
  subnet_ids     = module.vpc.private_subnet_ids
  instance_types = var.instance_types

  depends_on = [
    module.eks
  ]
}
