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
  region     = var.region
  cidrs      = var.cidrs
  subnet_ids = module.vpc.private_subnet_ids
  vpc_id     = module.vpc.vpc_id
}
module "nlb" {
  #Aplication/Network load balancer targeting ASG
  #receives outside traffic towards ASG in the private subnet
  source        = "./aws-modules/nlb"
  subnet_ids    = module.vpc.nlb_subnets_ids
  vpc_id        = module.vpc.vpc_id
  internal      = false
  target_groups = var.target_groups
  cidrs         = var.cidrs
}

/*




 module "RDS" {
    # mysql RDS multi az db cluster
 } */

/*  module "s3_assets" {

 } */