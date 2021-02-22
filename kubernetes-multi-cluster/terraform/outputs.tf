output "aws_eks_endpoint" {
  value = module.aws.eks_endpoint
}

output "aws_kubeconfig-ca" {
  value = module.aws.kubeconfig-certificate-authority-data
}

output "castai_kubeconfig" {
  value = module.castai.syntropy_kubeconfig
}

output "digitalocean_kubeconfig" {
  value = module.digitalocean.syntropy_kubeconfig
}

