

output "ami_ids" {
  value = {
    ubuntu_20 = data.aws_ami.ubuntu.id
  }
}