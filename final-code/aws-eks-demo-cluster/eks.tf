resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = [
      aws_subnet.public-subnet-1.id,
      aws_subnet.public-subnet-2.id,
      aws_subnet.private-subnet-1.id,
      aws_subnet.private-subnet-2.id,
    ]
    security_group_ids = [aws_security_group.kubernetes_master.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController
  ]

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster.name
}

resource "aws_eks_node_group" "ng-private" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "my-eks-nodegroup"
  node_role_arn   = aws_iam_role.ng-role.arn

  version = var.cluster_version
  subnet_ids = [
    aws_subnet.private-subnet-1.id,
    aws_subnet.private-subnet-2.id,
  ]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = var.instance_types
  capacity_type  = "ON_DEMAND"

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
  tags = {
    Name                                            = "Private-Node-Group"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "TRUE"
  }
}


/*resource "aws_eks_node_group" "ng-private" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "private-node-group"
  node_role_arn   = aws_iam_role.ng-role.arn
  subnet_ids      = [aws_subnet.private1.id, aws_subnet.private2.id]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  remote_access {
    ec2_ssh_key = var.ec2_key_pair_name
  }

  

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}
*/

