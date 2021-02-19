module "cast_ai" {
  source = "./cast_ai/"
}

module "aws" {
  source = "./aws/"
}

module "digitalocean" {
  source   = "./digital_ocean/"
  do_token = var.do_token
  pvt_key  = var.pvt_key
}