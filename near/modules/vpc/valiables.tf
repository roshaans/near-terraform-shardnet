variable "name" {
  type        = string
  description = "Name of the VPC"
  default     = "near-vpc"
}

variable "cidr_blocks" {
  type = object({
    vpc                 = string
    subnet_1_public     = string
    subnet_1_private    = string
    allowed_ssh_clients = string
  })
  description = "The cidr_blocks for the different subnets in a redundant Near network"
  default = {
    vpc                 = "10.10.0.0/16"
    subnet_1_public     = "10.10.0.0/24"
    subnet_1_private    = "10.10.1.0/24"
    allowed_ssh_clients = "0.0.0.0/0"
  }
}