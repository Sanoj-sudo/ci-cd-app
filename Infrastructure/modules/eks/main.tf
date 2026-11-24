
# =========================================
# EKS CLUSTER
# =========================================

resource "aws_eks_cluster" "main" {

  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = var.subnet_ids

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"

    # Only explicitly configured access entries
    # receive access through this configuration.
    bootstrap_cluster_creator_admin_permissions = false
  }

  tags = {
    Name        = var.cluster_name
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}


# =========================================
# IAM USERS - ACCESS ENTRIES
# =========================================

resource "aws_eks_access_entry" "iam_users" {

  for_each = toset(var.iam_user_arns)

  cluster_name  = aws_eks_cluster.main.name
  principal_arn = each.value

  type = "STANDARD"
}


# =========================================
# IAM USERS - CLUSTER ADMIN
# =========================================

resource "aws_eks_access_policy_association" "iam_users" {

  for_each = aws_eks_access_entry.iam_users

  cluster_name  = aws_eks_cluster.main.name
  principal_arn = each.value.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}


# =========================================
# GITHUB ACTIONS - ACCESS ENTRIES
# =========================================

resource "aws_eks_access_entry" "github_actions" {

  for_each = toset(var.github_actions_role_arns)

  cluster_name  = aws_eks_cluster.main.name
  principal_arn = each.value

  type = "STANDARD"
}


# =========================================
# GITHUB ACTIONS - CLUSTER ADMIN
# =========================================

resource "aws_eks_access_policy_association" "github_actions" {

  for_each = aws_eks_access_entry.github_actions

  cluster_name  = aws_eks_cluster.main.name
  principal_arn = each.value.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}


# =========================================
# ROOT ADMIN - ACCESS ENTRY
# =========================================

resource "aws_eks_access_entry" "root_admin" {

  cluster_name  = aws_eks_cluster.main.name
  principal_arn = var.root_admin_role_arn

  type = "STANDARD"
}


# =========================================
# ROOT ADMIN - CLUSTER ADMIN POLICY
# =========================================

resource "aws_eks_access_policy_association" "root_admin" {

  cluster_name  = aws_eks_cluster.main.name
  principal_arn = aws_eks_access_entry.root_admin.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
