output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = aws_eks_cluster.eks-cluster.id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = aws_eks_cluster.eks-cluster.arn
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = aws_eks_cluster.eks-cluster.endpoint
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = aws_eks_cluster.eks-cluster.version
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster."
  value       = aws_iam_role.cluster.arn
}

output "node_group_private_id" {
  description = "Node Group 1 ID"
  value       = aws_eks_node_group.ng-private.id
}

output "node_group_private_status" {
  description = "Private Node Group status"
  value       = aws_eks_node_group.ng-private.status
}