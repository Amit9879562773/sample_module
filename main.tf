provider "aws" {
  #region="ap-south-1"
  access_key = "AKIAZFKZDY6ZLZA2DCLF"
  secret_key = "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"
  profile    = "default"
  region     = "ap-south-1"
}

# create VPC

module "vpc" {

  source = "terraform-aws-modules/vpc/aws"
  name   = "my-vpc-1"
  cidr   = "10.0.0.0/16"

}

# create security group with inbound/outbound rules

module "simple_sg" {

    source = "terraform-aws-modules/security-group/aws"
    name = "sg1"
    vpc_id = module.vpc.vpc_id
    ingress_cidr_blocks = ["10.0.0.0/16"]
    ingress_rules       = ["https-443-tcp"]
    ingress_with_cidr_blocks = [
        {
            from_port = 8080
            to_port = 8090
            protocol = "tcp"
            cidr_blocks = "10.10.0.0/16"
        },
         {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    ]
    egress_cidr_blocks = ["10.10.0.0/16"]
    egress_with_cidr_blocks = [
        {
            rule = "http-80-tcp"
            cidr_blocks = "0.0.0.0/16"
        }
    ]
    
}

# create igw using module


# create public subnet

module "public_subnet" {

    
}