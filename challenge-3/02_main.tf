module "lb" {
    #Aplication/Network load balancer targeting ASG
    #receives outside traffic towards ASG in the private subnet
    source = ""
}

module "asg" {
    #ASG scales towards n+1 private subnetes

}

module "vpc" {
    # Subnet public x 3 (a,b,c) 
    # subnet private n+1 up to 3 (a,b,c)
    # deploys internet gateway on public subnet
    
}


 module "RDS" {
    # mysql RDS multi az db cluster
 }