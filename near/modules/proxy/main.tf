module "ami" {
  source = "../ami"
}

resource "aws_instance" "near_proxy" {
  

  ami                         = module.ami.ami_ids.ubuntu_18_04
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
    templatefile("${path.module}/../startup-scripts/install-nearup.sh", {     //Set up with running script
    validator_key  = var.proxy.validator_key
    node_key       = var.proxy.node_key
    account_id     = var.proxy.account_id
    stakingpool_id = var.proxy.stakingpool_id
    network        = var.network
    }),
    templatefile("${path.module}/../startup-scripts/install-monitoring.sh", {     //Set up with running script
    email_address  = var.proxy.gmail_address
    email_password = var.proxy.gmail_password
    stakingpool_id = var.proxy.stakingpool_id
    }),
    templatefile("${path.module}/../startup-scripts/install-warchest.sh", {     
    stakepool_id            = var.proxy.stakepool_id
    account_id              = var.proxy.account_id
    network                 = var.network
    seat_price_percentage   = var.proxy.seat_price_percentage
    lower_bid_threshold     = var.proxy.lower_bid_threshold
    upper_bid_threshold     = var.proxy.upper_bid_threshold
     }),
    file("${path.module}/../startup-scripts/final-hardening.sh")
  ])

  tags = {
    Name = "near-proxy-${var.proxy.validator_name}"
  }
}