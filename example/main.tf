provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.12.0"
  # We recommend using remote state for production configs. 
  # Uncomment and update the config block below to use remote state.
  #
  # backend "s3" {
  #     bucket          = "mybucket"
  #     key             = "mytfs/celo/terraform.tfstate"
  #     region          = "myregion"

  #     dynamodb_table  = "mydynamodb_table"
  #     encrypt         = true
  # }
}

module "celo_cluster" {
  source = "../betanet"

  region                       = var.region
  cidr_blocks                  = var.cidr_blocks
  key_pair_name                = var.key_pair_name
  near_image                   = var.celo_image
  near_network_id              = var.celo_network_id
  proxies                      = var.proxies
  validators                   = var.validators
  attestation_services         = var.attestation_services
}