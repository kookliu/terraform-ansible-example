##### for vpc :  igw vpc subnet  route-table nat
module "vpc" {
  source = "../terraform-modules/terraform-aws-vpc/"
  providers = {
    aws      = "aws.nx"
  }

  name = "nx-vpc"

  cidr = "10.0.0.0/16"

  azs             = ["cn-northwest-1a", "cn-northwest-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true


  tags = {
    Owner       = "cmct"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "cmct-vpc"
  }


}


module "vpc-bj" {
  source = "../terraform-modules/terraform-aws-vpc/"
  providers = {
    aws      = "aws.bj"
  }

  name = "bj-vpc"
  cidr = "172.0.0.0/16"

  azs             = ["cn-north-1a", "cn-north-1b"]
  private_subnets = ["172.0.1.0/24", "172.0.2.0/24"]
  public_subnets  = ["172.0.101.0/24", "172.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true


  tags = {
    Owner       = "cmct"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "cmct-vpc"
  }


}




