module "ami" {
  source = "../ami"
}

resource "aws_instance" "near_validator" {
  for_each = var.validators

  ami                    = module.ami.ami_ids.ubuntu_18_04
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_pair_name

  root_block_device {
    volume_size = var.volume_size
  }

  user_data = join("\n", [
    file("${path.module}/../startup-scripts/install-base.sh"),
    file("${path.module}/../startup-scripts/install-docker.sh"),
    file("${path.module}/../startup-scripts/install-chrony.sh"),
    templatefile("${path.module}/../startup-scripts/run-validator-node.sh", {

    }),
    file("${path.module}/../startup-scripts/final-hardening.sh")
  ])

  tags = {
    Name = "near-validator-${each.value.name}"
  }
}