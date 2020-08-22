//------------------------------------------------
//                     Testnet                   |
//------------------------------------------------

provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.12.0"
   
   
   backend "s3" {
       bucket          = "near-protocol"
       key             = "near/testnet/terraform.tfstate"
       region          = "us-west-1"

       dynamodb_table  = "app-state"
       encrypt         = true
   }
}

module "near_cluster" {
  source = "../../near"
  initial_startup              = var.initial_startup
  region                       = var.region
  network                      = var.network
  twilio                       = var.twilio
  docker_image                 = var.docker_image
  cidr_blocks                  = var.cidr_blocks
  key_pair_name                = var.key_pair_name
  validator                    = var.validator
}