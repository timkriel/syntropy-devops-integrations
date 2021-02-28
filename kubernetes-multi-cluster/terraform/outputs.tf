output "aws_eks_endpoint" {
  value = module.aws.eks_endpoint
}

output "aws_kubeconfig-ca" {
  value = module.aws.kubeconfig-certificate-authority-data
}

output "castai_kubeconfig" {
  value = module.castai.syntropy_kubeconfig
}

resource "local_file" "castai_kubeconfig" {
    content  = module.castai.syntropy_kubeconfig
    filename = "castai/kubernetes/kubeconfig"
}

output "digitalocean_kubeconfig" {
  value = module.digitalocean.syntropy_kubeconfig
}