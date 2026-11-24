
output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "root_admin_role_arn" {
  value = aws_iam_role.root_eks_admin.arn
}
