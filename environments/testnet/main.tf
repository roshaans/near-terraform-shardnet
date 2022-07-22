//------------------------------------------------
//                     Testnet                   |
//------------------------------------------------

provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.12.0"


  backend "s3" {
    bucket = "near-protocol"
    key    = "near/testnet/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "app-state"
    encrypt        = true
  }
}

module "near_cluster" {
  source          = "../../near"
  initial_startup = var.validator.initial_startup
  region          = var.validator.region
  network         = var.network
  twilio          = var.twilio.twilio
  cidr_blocks     = var.validator.cidr_blocks
  key_pair_name   = var.validator.key_pair_name
  validator       = var.validator.validator
}