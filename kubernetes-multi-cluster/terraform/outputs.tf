output "aws_eks_endpoint" {
  value = module.aws.endpoint
}

output "aws_kubeconfig-ca" {
  value = module.aws.kubeconfig-certificate-authority-data
}

output "cast_ai_kubeconfig" {
  value = module.cast_ai.syntropy_kubeconfig
}