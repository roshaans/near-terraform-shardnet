//------------------------------------------------
//                     Betanet                   |
//------------------------------------------------

variable region {
  type        = string
  description = "AWS Region to provision this cluster"
}

variable cidr_blocks {
  type = object({
    vpc                 = string
    subnet_1_public   = string
    subnet_1_private  = string
    allowed_ssh_clients = string
  })
  description = "The cidr_blocks for the different subnets in a redundant Near network"
  
  default = {
    vpc                 = "10.10.0.0/16"
    subnet_1_public   = "10.10.0.0/24"
    subnet_1_private  = "10.10.1.0/24"
    allowed_ssh_clients = "0.0.0.0/0"
  }
}

variable key_pair_name {
  type        = string
  description = "SSH key pair name"
}

variable network {
  type        = string
  description = "Near network" #eg Betanet, Testnet or Mainnet
}

variable twilio {

 description = "Configuration for twilio messaging service"
  type = object({
    twilio_messaging_service_sid  = string
    twilio_account_sid            = string
    twilio_auth_token             = string
    twilio_number_to_send         = string
    twilio_number                 = string
  })
}

variable validator {
  description = "Configuration for zero or more proxies in each availability zone."
  type = object({
   validator_name            = string
    gmail_address             = string
    gmail_password            = string
    validator_key             = string
    node_key                  = string
    account_id                = string
    stakingpool_id            = string
    #Warchest configuration
    seat_price_percentage     = number
    lower_bid_threshold       = number
    upper_bid_threshold       = number
    })
}


variable initial_startup {
  type        = bool
  description = "Will allow the initial startup and sync of nearcore" 
}


