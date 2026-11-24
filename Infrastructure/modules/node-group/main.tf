
resource "aws_eks_node_group" "main" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn

  subnet_ids = var.subnet_ids

  instance_types = var.instance_types

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 4
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
