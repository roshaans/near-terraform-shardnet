output instances {
  value = aws_instance.near_validator
}

output public_ip {
  value = aws_instance.near_validator.public_ip
}

output private_ip {
  value = aws_instance.near_validator.private_ip
}