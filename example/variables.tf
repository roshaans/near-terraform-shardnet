variable region {
  type        = string
  description = "AWS Region to provision this cluster"
  default     = "us-west-1"
}

variable cidr_blocks {
  type = object({
    vpc                 = string
    subnet_az1_public   = string
    subnet_az1_private  = string
    subnet_az2_public   = string
    subnet_az2_private  = string
    allowed_ssh_clients = string
  })
  description = "The cidr_blocks for the different subnets in a redundant Near network"
  default = {
    vpc                 = "10.10.0.0/16"
    subnet_az1_public   = "10.10.0.0/24"
    subnet_az1_private  = "10.10.1.0/24"
    subnet_az2_public   = "10.10.10.0/24"
    subnet_az2_private  = "10.10.11.0/24"
    allowed_ssh_clients = "0.0.0.0/0"
  }
}

variable key_pair_name {
  type        = string
  description = "SSH key pair name"
}

variable near_image {
  type        = string
  description = "Docker image for Near nodes"
  default     = "us.gcr.io/celo-testnet/celo-node:baklava"
}

variable near_network_id {
  type        = string
  description = "ID of the Near network to join"
  default     = "40120"
}



variable proxies {
  description = "Configuration for zero or more proxies in each availability zone."
  type = object({
    az1 = map(object({
    //Insert vars needed
    }))

  default = {
    az1 = {}
  }
}

variable validators {
  description = "Configuration for zero or more validators in each availability zone"
  type = object({
    az1 = map(object({
    }))
 
  })
  default = {
    az1 = {}
  }

}






}