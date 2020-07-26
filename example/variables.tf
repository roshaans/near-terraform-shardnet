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

variable proxy {
  description = "Configuration for zero or more proxies in each availability zone."
  type = object({
    validator_name = string
    gmail_address  = string
    gmail_password = string
    validator_key  = string
    node_key       = string
    account_id     = string
    stakingpool_id = string
    })

  default = {    
      validator_name = "test"
      gmail_address  = "test"
      gmail_password = "test"
      validator_key  = "test"
      node_key       = "test"
      account_id     = "test"
      stakingpool_id = "test"
      }
}

variable validator {
  description = "Configuration for zero or more validators in each availability zone"
  type = object({
    validator_name = string
 
  })

  default = {
     validator_name = "test"
    }
  }


