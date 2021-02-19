output "eks_endpoint" {
  value = aws_eks_cluster.syntropy.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.syntropy.certificate_authority[0].data
}