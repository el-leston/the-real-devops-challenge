output "private_subnet_ids" {
  value = data.aws_subnets.private_subnets.ids
}

output "public_subnet_ids" {
  value = data.aws_subnets.public_subnets.ids
}
output "nlb_subnets_ids" {
  value = data.aws_subnets.nlb_subnets.ids
}

output "vpc_id" {
  value = aws_vpc.this.id  
}
output default_sg_id {
  value       = aws_default_security_group.default.id
  description = "default sg"
}
