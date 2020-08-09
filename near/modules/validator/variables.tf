  
variable instance_type {
  type        = string
  description = "AWS instance type for this node"
}

variable subnet_id {
  type        = string
  description = "Subnet ID to place this proxy. This should be a public subnet from your near VPC."
}

variable security_group_id {
  type        = string
  description = "VPC Security group for this instance"
}

variable key_pair_name {
  type        = string
  description = "Name of the SSH key pair to access this node from the bastion"
}

variable volume_size {
  type        = number
  description = "GB size for the EBS volume"
  default     = 256
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

variable network {
  type        = string
  description = "Near network" #eg Betanet, Testnet or Mainnet
}

variable twilio {

 description = "Configuration for twilio msg service"
  type = object({
    twilio_messaging_service_sid  = string
    twilio_account_sid            = string
    twilio_auth_token             = string
    twilio_number_to_send         = string
    twilio_number                 = string
  })
}

variable docker_image {
  type        = string
  description = "Name of your docker repository" 
}


