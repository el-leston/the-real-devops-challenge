#READY  
module "vpc" {
  source = "./aws-modules/vpc"
  # Subnet public x 3 (a,b,c) 
  # subnet private n+1 up to 3 (a,b,c)
  # deploys internet gateway on public subnet
  region  = var.region
  cidrs   = var.cidrs
  subnets = var.subnets

}
#READY  
module "asg" {
  source = "./aws-modules/asg"
  #ASG scales towards n+1 private subnetes
  region     = var.region
  cidrs      = var.cidrs
  subnet_ids = module.vpc.private_subnet_ids
  vpc_id     = module.vpc.vpc_id
  asg_name   = var.asg_name
  
  depends_on = [module.vpc]

}
#READY  
module "nlb" {
  #/Network load balancer targeting ASG public subnet A and private subnet B
  #receives outside traffic towards ASG in the private subnet
  source        = "./aws-modules/nlb"
  subnet_ids    = module.vpc.nlb_subnets_ids
  vpc_id        = module.vpc.vpc_id
  internal      = false
  target_groups = var.target_groups
  cidrs         = var.cidrs
  #asg_name      = var.asg_name
  depends_on = [module.asg, module.vpc]
}

 #READY  
 /*
 module "rds" {
    # mysql RDS multi az db cluster
    source        = "./aws-modules/rds"
    subnet_ids    = module.vpc.private_subnet_ids
    vpc_id        = module.vpc.vpc_id
    cidrs         = var.cidrs
 } 
 */

/*  module "s3_assets" {

 } */