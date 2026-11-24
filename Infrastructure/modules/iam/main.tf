
# =========================================
# EKS CLUSTER IAM ROLE
# =========================================

resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "eks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  role = aws_iam_role.cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


# =========================================
# EKS WORKER NODE IAM ROLE
# =========================================

resource "aws_iam_role" "node" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "worker_policy" {
  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


# =========================================
# ROOT USER EKS ADMIN ROLE
# =========================================

resource "aws_iam_role" "root_eks_admin" {
  name = "EKSRootAdminRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        AWS = "arn:aws:iam::${var.root_account_id}:root"
      }

      Action = "sts:AssumeRole"

      Condition = {
        ArnEquals = {
          "aws:PrincipalArn" = "arn:aws:iam::${var.root_account_id}:root"
        }
      }
    }]
  })
}


# =========================================
# ROOT ROLE - EKS DESCRIBE PERMISSION
# =========================================

resource "aws_iam_role_policy" "root_eks_describe" {
  name = "EKSDescribeCluster"
  role = aws_iam_role.root_eks_admin.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "eks:DescribeCluster"
      ]

      Resource = "*"
    }]
  })
}
