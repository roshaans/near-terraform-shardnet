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
  #     key             = "mytfs/near/terraform.tfstate"
  #     region          = "myregion"

  #     dynamodb_table  = "mydynamodb_table"
  #     encrypt         = true
  # }
}

module "near_cluster" {
  source = "../near"

  region                       = var.region
  network                      = var.network
  cidr_blocks                  = var.cidr_blocks
  key_pair_name                = var.key_pair_name
  proxy                        = var.proxy
  validator                    = var.validator
}