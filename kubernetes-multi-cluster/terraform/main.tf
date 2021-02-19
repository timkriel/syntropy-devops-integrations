module "castai" {
  source = "./castai/"
}

module "aws" {
  source = "./aws/"
}

module "digitalocean" {
  source   = "./digitalocean/"
}