module "vpc" {
    source = "./aws-modules/vpc"
    # Subnet public x 3 (a,b,c) 
    # subnet private n+1 up to 3 (a,b,c)
    # deploys internet gateway on public subnet
    region  = var.region
    cidrs   = var.cidrs
    subnets = var.subnets
    
}
module "asg" {
    source = "./aws-modules/asg"
    #ASG scales towards n+1 private subnetes
    region  = var.region
    cidrs   = var.cidrs
    subnet_ids = module.vpc.private_subnet_ids 
    vpc_id  = module.vpc.vpc_id
}
/* module "lb" {
    #Aplication/Network load balancer targeting ASG
    #receives outside traffic towards ASG in the private subnet
    source = ""
}






 module "RDS" {
    # mysql RDS multi az db cluster
 } */