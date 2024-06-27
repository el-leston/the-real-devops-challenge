data "aws_nat_gateway" "default" {
  count = var.nat_gateway_id == null ? 0 : 1

  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private-*"] 
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["public-*"] 
  }
}

data "aws_subnets" "nlb_subnets" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-a", "private-subnet-b", "private-subnet-c"] 
  }
}

data "aws_security_groups" "nlb-sg-ids" {
  filter {
    name   = "group-name"
    values = ["nlb-sg"]
  }
}