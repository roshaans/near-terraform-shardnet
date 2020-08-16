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
       key             = "${var.bucket}/${var.network}/terraform.tfstate"
       region          = "app-state"

       dynamodb_table  = "mydynamodb_table"
       encrypt         = true
   }
}

module "near_cluster" {
  source = "../../near"

  region                       = var.region
  network                      = var.network
  twilio                       = var.twilio
  docker_image                 = var.docker_image
  cidr_blocks                  = var.cidr_blocks
  key_pair_name                = var.key_pair_name
  validator                    = var.validator
  aws_credentials              = var.credentials
}