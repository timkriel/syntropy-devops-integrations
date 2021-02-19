terraform {
  required_providers {
    castai = {
      source = "castai/castai"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.4.0"
    }
  }
  required_version = ">= 0.13, < 0.14"
}

provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "~/.aws/credentials"
}

provider "digitalocean" {
  token = var.do_token
}

provider "castai" {
  api_token = var.castai_token
}

