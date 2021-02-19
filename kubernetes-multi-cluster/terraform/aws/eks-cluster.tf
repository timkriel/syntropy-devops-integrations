resource "aws_eks_cluster" "syntropy" {
  name     = "syntropy"
  role_arn = aws_iam_role.syntropy-eks.arn

  vpc_config {
    subnet_ids = [aws_subnet.syntropy-private.0.id, aws_subnet.syntropy-private.1.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.syntropy-AmazonEKSClusterPolicy
  ]
}

resource "aws_iam_role" "syntropy-eks" {
  name = "eks-cluster-syntropy"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "syntropy-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.syntropy-eks.name
}

resource "aws_eks_node_group" "syntropy" {
  cluster_name    = aws_eks_cluster.syntropy.name
  node_group_name = "syntropy-eks-nodes"
  node_role_arn   = aws_iam_role.syntropy-eks-nodes.arn
  subnet_ids      = aws_subnet.syntropy-private[*].id
  instance_types  = ["t2.micro"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.syntropy-eks-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.syntropy-eks-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.syntropy-eks-nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "syntropy-eks-nodes" {
  name = "syntropy-eks-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "syntropy-eks-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.syntropy-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "syntropy-eks-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.syntropy-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "syntropy-eks-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.syntropy-eks-nodes.name
}