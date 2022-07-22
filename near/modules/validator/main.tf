module "ami" {
  source = "../ami"
}

resource "aws_instance" "near_validator" {
  ami                         = module.ami.ami_ids.ubuntu_20
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.volume_size
  }



  user_data = join("\n", [
    file("${path.module}/../startup-scripts/install-base.sh"),
    file("${path.module}/../startup-scripts/install-docker.sh"),
    file("${path.module}/../startup-scripts/install-chrony.sh"),
    templatefile("${path.module}/../startup-scripts/setup-node.sh", { //Set up with running script
      validator_key  = var.validator.validator_key
      node_key       = var.validator.node_key
      account_id     = var.validator.account_id
      stakingpool_id = var.validator.stakingpool_id
      network        = var.network
      initialstartup = var.initial_startup
    }),

    templatefile("${path.module}/../startup-scripts/install-monitoring.sh", { //Set up with running script
      email_address  = var.validator.gmail_address
      email_password = var.validator.gmail_password
      stakingpool_id = var.validator.stakingpool_id
    }),

    templatefile("${path.module}/../startup-scripts/install-ci.sh", {
      twilio_msg_sid     = var.twilio.twilio_messaging_service_sid
      twilio_account_sid = var.twilio.twilio_account_sid
      twilio_auth_token  = var.twilio.twilio_auth_token
      number_to_send     = var.twilio.twilio_number_to_send
      twilio_number      = var.twilio.twilio_number
      network            = var.network

    }),
    file("${path.module}/../startup-scripts/final-hardening.sh")
  ])

  tags = {
    Name = "near-validator-${var.validator.validator_name}"
  }
}