region = "eu-central-1"
cidrs = {
    primary   ="172.10.0.0/25"
    secondary = ["172.10.0.128/25"]
}
subnets = {
    public_subnet_1 = {
    availability_zones = ["a"]
    cidr_block         = "172.10.0.0/26"
    IsPrivate          = false
    Isroutable         = true
    subnetName         = "public-subnet-a"
    },
    public_subnet_2 = {
    availability_zones = ["b"]
    cidr_block         = "172.10.0.64/27"
    IsPrivate          = false
    Isroutable         = true
    subnetName         = "public-subnet-b"
  },
    public_subnet_3 = {
    availability_zones = ["c"]
    cidr_block         = "172.10.0.96/27"
    IsPrivate          = false
    Isroutable         = true
    subnetName         = "public-subnet-c"
  },
    private_subnet_1 = {
    availability_zones = ["a"]
    cidr_block         = "172.10.0.128/26"
    IsPrivate          = true
    Isroutable         = true
    subnetName         = "private-subnet-a"
  },
    private_subnet_2 = {
    availability_zones = ["b"]
    cidr_block         = "172.10.0.192/27"
    IsPrivate          = true
    Isroutable         = true
    subnetName         = "private-subnet-b"
  },
    private_subnet_3 = {
    availability_zones = ["c"]
    cidr_block         = "172.10.0.224/27"
    IsPrivate          = true
    Isroutable         = true
    subnetName         = "private-subnet-c"
  }
  

}