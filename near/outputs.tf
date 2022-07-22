output "public_ip" {
  value = module.near_bastion.public_ip
}

output "private_ip" {
  value = module.near_validator.private_ip
}