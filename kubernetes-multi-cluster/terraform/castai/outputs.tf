output "syntropy_kubeconfig" {
  value = castai_cluster.syntropy.kubeconfig
}

resource "local_file" "castai_kubeconfig" {
    content  = castai_cluster.syntropy.kubeconfig
    filename = "castai/kubernetes/kubeconfig"
}