output security_group_ids {
  value = {
    bastion             = aws_security_group.bastion.id
    full_node           = aws_security_group.full_node.id
    validator           = aws_security_group.validator.id
    proxy               = aws_security_group.proxy.id
  }
}

output subnet_ids {
  value = {
    az1 = {
      private = module.near_private_subnet_1.id
      public  = module.near_public_subnet_1.id
    }
  }
}

output id {
  value = aws_vpc.near.id
}