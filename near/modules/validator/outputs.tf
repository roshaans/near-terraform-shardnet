output "instances" {
  value = aws_instance.near_validator
}

output "private_ip" {
  value = aws_instance.near_validator.private_ip
}