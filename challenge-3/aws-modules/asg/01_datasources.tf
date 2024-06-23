data "aws_security_groups" "this" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
data "aws_security_groups" "nlb-sg" {
  filter {
    name   = "group-name"
    values = ["nlb-sg"]
  }
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


data "aws_subnets" "nat_public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-a"] 
  }
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id
  tags  = {
    Name = "private-rt"
  }
}

