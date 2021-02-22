terraform {
  required_version = ">= 0.14.6"
}

module "aws" {
  source = "./aws/"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}

module "castai" {
  source = "./castai/"
  castai_token = var.castai_token
}

module "digitalocean" {
  source   = "./digitalocean/"
  do_token = var.do_token
}