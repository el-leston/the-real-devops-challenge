resource "aws_vpc" "this" {
  cidr_block       = var.cidrs.primary # ".0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "VPC"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  #for_each = toset(var.cidrs.primary)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.cidrs.secondary,0)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id            = local.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = "${var.region}${each.value.availability_zones[0]}"

  tags = {
    Name = each.value.subnetName != "" ? each.value.subnetName : "subnet-${each.key}"
  }

  lifecycle {
    create_before_destroy = true
  }
}


# Create a route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = local.vpc_id

  tags = {
    Name = "public-rt"
  }
}

# Create a route to the Internet Gateway in the public route table
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


# Create a route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = local.vpc_id

  tags = {
    Name = "private-rt"
  }
}

# Create a route to the NAT Gateway in the private route table if is already created in console(to avoid cost)
resource "aws_route" "private" {
  count                  = try(data.aws_nat_gateway.default[0].id, null) != null? 1:0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.default[0].id
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public.id

  lifecycle {
    create_before_destroy = true
  }
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private" {
  for_each = local.private_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.private.id

  lifecycle {
    create_before_destroy = true
  }
}

