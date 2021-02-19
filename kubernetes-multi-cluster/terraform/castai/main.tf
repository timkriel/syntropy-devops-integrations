resource "castai_cluster" "syntropy" {
  name   = "syntropy"
  region = "eu-central"
  credentials = [
    data.castai_credentials.existing_gcp.id
  ]

  initialize_params {
    nodes {
      cloud = "gcp"
      role  = "master"
      shape = "small"
    }
    nodes {
      cloud = "gcp"
      role  = "worker"
      shape = "small"
    }
  }
}