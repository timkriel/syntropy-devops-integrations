output "syntropy_kubeconfig" {
  value = digitalocean_kubernetes_cluster.syntropy.kube_config.0.raw_config
}