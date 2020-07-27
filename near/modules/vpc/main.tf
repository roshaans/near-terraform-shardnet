resource "aws_vpc" "near" {
  cidr_block = var.cidr_blocks.vpc

  tags = {
    Name = var.name
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.near.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.near.id

  tags = {
    Name = "near-internet-gateway"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}


module "near_public_subnet_1" {
  source = "./modules/subnet-public"

  vpc_id                         = aws_vpc.near.id
  cidr_block                     = var.cidr_blocks.subnet_1_public
  internet_gateway_id            = aws_internet_gateway.igw.id
  availability_zone_id           = data.aws_availability_zones.available.zone_ids[0]
  allowed_ssh_clients_cidr_block = var.cidr_blocks.allowed_ssh_clients
}

module "near_private_subnet_1" {
  source = "./modules/subnet-private"

  vpc_id               = aws_vpc.near.id
  cidr_block           = var.cidr_blocks.subnet_1_private
  availability_zone_id = data.aws_availability_zones.available.zone_ids[0]
  nat_gateway_id       = module.near_public_subnet_1.nat_gateway_id
  vpc_cidr_block       = aws_vpc.near.cidr_block
}



resource "aws_security_group" "bastion" {
  name   = "near-bastion"
  vpc_id = aws_vpc.near.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks.allowed_ssh_clients]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "full_node" {
  name   = "near-full-node"
  vpc_id = aws_vpc.near.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "validator" {
  name   = "near-validator"
  vpc_id = aws_vpc.near.id
}

resource "aws_security_group_rule" "validator_allow_internal_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.validator.id
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "validator_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.validator.id
  cidr_blocks       = ["0.0.0.0/0"]
}


//-------------------------New-----------------------------------


resource "aws_security_group_rule" "validator_allow_node_exporter_inbound" {
  type              = "ingress"
  from_port         = 9100
  to_port           = 9100
  protocol          = "tcp"
  security_group_id = aws_security_group.validator.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "validator_allow_near_prometheus_exporter_inbound" {
  type              = "ingress"
  from_port         = 9333
  to_port           = 9333
  protocol          = "tcp"
  security_group_id = aws_security_group.validator.id
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "validator_allow_near_node_inbound" {
  type              = "ingress"
  from_port         = 3030
  to_port           = 3030
  protocol          = "tcp"
  security_group_id = aws_security_group.validator.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "validator_allow_prometheus_inbound" {
  type              = "ingress"
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  security_group_id = aws_security_group.validator.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "validator_allow_grafana_inbound" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.validator.id
  cidr_blocks       = ["0.0.0.0/0"]
}
