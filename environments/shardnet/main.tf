//------------------------------------------------
//                     Betanet                   |
//------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

# terraform {
#   required_version = ">= 0.12.0"

#    backend "s3" {
#        bucket          = "near-protocol"
#        key             = "near/betanet/terraform.tfstate"
#        region          = "us-west-1"

#        dynamodb_table  = "app-state"
#        encrypt         = true
#    }
# }

module "near_cluster" {
  source = "../../near"

  initial_startup = var.initial_startup
  region          = var.region
  network         = var.network
  twilio          = var.twilio
  cidr_blocks     = var.cidr_blocks
  validator       = var.validator
}

output "private_ip" {
  value = module.near_cluster.private_ip
}
