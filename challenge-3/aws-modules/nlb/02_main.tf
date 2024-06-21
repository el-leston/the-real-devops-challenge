resource "aws_lb" "this" {
  name               = "nlb"
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.nlb-sg.id]

  enable_deletion_protection = false # TESTING PURPOSE

  tags = {
    Environment = "dev"
  }
}


resource "aws_lb_listener" "this" {
  for_each = var.target_groups
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }
}


resource "aws_lb_target_group" "this" {
  for_each      = var.target_groups
  name          = lookup(each.value, "name", null)
  port          = lookup(each.value, "port", null)
  target_type   = lookup(each.value, "target_type", null)
  protocol      = lookup(each.value, "protocol", null)
  vpc_id        = var.vpc_id

  target_health_state {
    enable_unhealthy_connection_termination = false
  }


  health_check {
    enabled     = true
    interval    = 9
    port        = "traffic-port"
    path        = "/"
    protocol    = lookup(each.value, "health_check_protocol", null)
  }
}


# Security group for the Network Load Balancer
resource "aws_security_group" "nlb-sg" {
  name_prefix = "el-"
  description = "NLB security group"
  vpc_id      = var.vpc_id
    // inbound vpc access
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidrs.primary, var.cidrs.secondary[0]]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    //  outbound alloance access 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidrs.primary, var.cidrs.secondary[0]]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = [var.cidrs.primary, var.cidrs.secondary[0]]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidrs.primary, var.cidrs.secondary[0]]
  }

  tags = {
    Name = "nlb-sg"
  }
}
