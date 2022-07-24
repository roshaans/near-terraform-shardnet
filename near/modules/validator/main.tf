module "ami" {
  source = "../ami"
}

resource "aws_instance" "near_validator" {
  ami                         = module.ami.ami_ids.ubuntu_20
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_admin.name
  associate_public_ip_address = true
  monitoring                  = true
  root_block_device {
    volume_size = var.volume_size
  }



  user_data = join("\n", [
    file("${path.module}/../startup-scripts/install-docker.sh"),
    templatefile("${path.module}/../startup-scripts/setup-validator.sh", { //Set up with running script
      validator_key = var.validator.validator_key
      # node_key       = var.validator.node_key
      my_root_password = "root"
      account_id       = var.validator.account_id
      stakingpool_id   = var.validator.stakingpool_id
      network          = var.network
      initialstartup   = var.initial_startup
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
    templatefile("${path.module}/../startup-scripts/setup-cron-ping-job.sh", {
      POOLID    = var.validator.stakingpool_id
      ACCOUNTID = var.validator.account_id
    }),
  ])

  tags = {
    Name = "near-validator-${var.validator.validator_name}"
  }
}
# IAM Policy with assume role to EC2
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Configure IAM role
resource "aws_iam_role" "ec2_admin" {
  name               = "ec2-admin"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# Configure IAM instance profile
resource "aws_iam_instance_profile" "ec2_admin" {
  name = "ec2-admin"
  role = aws_iam_role.ec2_admin.name
}

resource "aws_iam_user_policy" "ssm_user" {
  name = "ssm-user"
  user = aws_iam_user.ssm_user.name

  policy = file("${path.module}/json-policies/ssm-user.json")
}

resource "aws_iam_role_policy" "ec2_admin" {
  name = "ec2-admin"
  role = aws_iam_role.ec2_admin.id

  policy = file("${path.module}/json-policies/ec2-admin.json")
}

resource "aws_iam_user" "ssm_user" {
  name          = "ssm-user"
  path          = "/"
  force_destroy = true

  tags = {
    "Name" = "ssm-user"
  }
}

locals {
  cloud_config_config = <<-END
    #cloud-config
    ${jsonencode({
  write_files = [
    {
      path        = "~/setup-node.sh"
      permissions = "0644"
      owner       = "root:root"
      encoding    = "b64"
      content     = filebase64("${path.module}/../startup-scripts/setup-node.sh")
    },
  ]
})}
  END
}

