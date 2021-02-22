terraform {
  required_providers {
    castai = {
      source = "castai/castai"
      version = ">= 0.3.0"
    }
  }
}

provider "castai" {
  api_token = var.castai_token
}

