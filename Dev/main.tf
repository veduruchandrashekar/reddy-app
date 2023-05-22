provider "aws" {
  region = "eu-west-2"
}



module "vpc" {
  source = "../modules/vpc"
  instance_tenancy = "default"
  vpc_id = module.vpc.vpc_id
  subnet_id1 = module.vpc.subnet_id1
  subnet_id2 = module.vpc.subnet_id2
}

module "eks" {
  source = "../modules/eks"
  subnet_id1 = module.vpc.subnet_id1
  subnet_id2 = module.vpc.subnet_id2
}
