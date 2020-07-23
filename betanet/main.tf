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

nstance_type     = var.instance_types.bastion
}

module "near_proxy" {
  source = "./modules/proxy"

  subnet_id         = module.near_vpc.subnet_ids.az1.public
  security_group_id = module.near_vpc.security_group_ids.proxy
  key_pair_name     = var.key_pair_name
  instance_type     = var.instance_types.proxy
  celo_image        = var.near_image
  celo_network_id   = var.near_network_id


  proxies = var.proxies.az1
}



locals {
  validator_proxy_settings = {
    az1 = zipmap(
      keys(var.proxies.az1),
      [for k, v in var.proxies.az1 : {
        proxy_private_ip = module.near_proxy_az1.instances[k].private_ip
        proxy_public_ip  = module.near_proxy_az1.instances[k].public_ip
        }
      ]
    )
  }
  validator_params = {
    az1 = zipmap(
      keys(var.validators.az1),
      [for k, v in var.validators.az1 : merge(var.validators.az1[k], lookup(local.validator_proxy_settings.az1, k, {}))]
    )
  }
}

module "near_validator_1" {
  source = "./modules/validator"

  subnet_id         = module.near_vpc.subnet_ids.az1.private
  security_group_id = module.near_vpc.security_group_ids.validator
  key_pair_name     = var.key_pair_name
  instance_type     = var.instance_types.validator
  near_image        = var.celo_image
  near_network_id   = var.celo_network_id

  validators = local.validator_params.az1
}


resource "random_password" "password" {
  length      = 50
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}







