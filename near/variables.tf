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
  description = "The cidr_blocks for the different subnets in a redundant near network"
  default = {
    vpc                 = "10.10.0.0/16"
    subnet_1_public   = "10.10.0.0/24"
    subnet_1_private  = "10.10.1.0/24"
    allowed_ssh_clients = "0.0.0.0/0"
  }
}

variable instance_types {
  description = "The instance type for each component"
  type        = map(string)

  default = {
    bastion             = "t3.micro"
    proxy               = "t3.medium" # t3.medium to keep costs low in dev. Use c5.xlarge or similar in production
    validator           = "t3.medium" # t3.medium to keep costs low in dev. Use c5.xlarge or similar in production
  }
}

variable key_pair_name {
  type        = string
  description = "AWS Key Pair name for SSH access"
}

variable validator {
  description = "Configuration for zero or more proxies in each availability zone."
  type = object({
    validator_name = string
    gmail_address  = string
    gmail_password = string
    validator_key  = string
    node_key       = string
    account_id     = string
    stakingpool_id = string
    #Warchest configuration
    seat_price_percentage = number
    lower_bid_threshold = number
    upper_bid_threshold = number
  })
}


variable network {
  type        = string
  description = "Near network" #eg Betanet, Testnet or Mainnet
}
