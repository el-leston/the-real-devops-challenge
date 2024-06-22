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