provider "aws" {
  region = var.region
}

module "near_vpc" {
  source = "./modules/vpc"

  name        = "near-vpc"
  cidr_blocks = var.cidr_blocks
}

module "near_bastion" {
  source = "./modules/bastion"

  subnet_id         = module.near_vpc.subnet_ids.az1.public
  security_group_id = module.near_vpc.security_group_ids.bastion
  key_pair_name     = var.key_pair_name
  name              = "near-bastion"
  instance_type     = var.instance_types.bastion
}


module "near_proxy" {
  source = "./modules/proxy"

  subnet_id         = module.near_vpc.subnet_ids.az1.public
  security_group_id = module.near_vpc.security_group_ids.proxy
  key_pair_name     = var.key_pair_name
  instance_type     = var.instance_types.proxy

  proxy = var.proxy
}

module "near_validator" {
  source = "./modules/validator"

  subnet_id         = module.near_vpc.subnet_ids.az1.private
  security_group_id = module.near_vpc.security_group_ids.validator
  key_pair_name     = var.key_pair_name
  instance_type     = var.instance_types.validator

  validator = var.validator
}

resource "random_password" "password" {
  length      = 50
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}







