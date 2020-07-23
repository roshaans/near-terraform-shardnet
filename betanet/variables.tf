variable region {
  type        = string
  description = "AWS Region to provision this cluster"
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
  description = "The cidr_blocks for the different subnets in a redundant Celo network"
  default = {
    vpc                 = "10.10.0.0/16"
    subnet_az1_public   = "10.10.0.0/24"
    subnet_az1_private  = "10.10.1.0/24"
    subnet_az2_public   = "10.10.10.0/24"
    subnet_az2_private  = "10.10.11.0/24"
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

variable near_image {
  type        = string
  description = "Docker image for near nodes"
}

variable near_network_id {
  type        = string
  description = "ID of the near network to join"
}



variable proxies {
  description = "Configuration for zero or more proxies in each availability zone."
  type = object({
    az1 = map(object({
      validator_name                  = string
      validator_signer_address        = string
      proxy_address                   = string
      proxy_private_key_filename      = string
      proxy_private_key_file_contents = string
      proxy_private_key_password      = string
      proxy_node_private_key          = string
      proxy_enode                     = string
    }))
  })
}

variable validators {
  description = "Configuration for zero or more validators in each availability zone"
  type = object({
    az1 = map(object({
      name                             = string
      signer_address                   = string
      signer_private_key_filename      = string
      signer_private_key_file_contents = string
      signer_private_key_password      = string
    }))
  })
}

