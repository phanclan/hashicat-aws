provider "aws" {
  region = local.region
}

variable "deploy_env" {
  type = list(string)
  default = ["prod", "qa", "dev"]
}

# Module level count argument and depends_on vpc module.
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  count = length(var.deploy_env)
  region = "us-west-2"
  bucket = "s3-20200706-${var.deploy_env[count.index]}"

  depends_on = [module.vpc]
}

# module "vpc" {
#   source               = "terraform-aws-modules/vpc/aws"
#   name                 = "tf-vpc-uw1-frontend"
#   cidr                 = local.cidr
#   azs                  = local.azs
#   public_subnets       = local.public_subnets
#   private_subnets      = local.private_subnets
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   # enable_nat_gateway   = true
#   # single_nat_gateway = true
#   # tags                     = local.common_tags
#   # igw_tags                 = { Name = "${var.prefix}-${var.env}-usw2-1-IGW" }
#   # nat_gateway_tags         = { Name = "${var.prefix}-${var.env}-usw2-1-NGW" }
#   # public_route_table_tags  = { Name = "${var.prefix}-${var.env}-usw2-1-RT-public" }
#   # public_subnet_tags       = { Name = "${var.prefix}-${var.env}-usw2-1-public" }
#   # private_route_table_tags = { Name = "${var.prefix}-${var.env}-usw2-1-RT-private" }
#   # private_subnet_tags      = { Name = "${var.prefix}-${var.env}-usw2-1-private" }
#   private_subnet_tags = { "Tier" : "private" }
#   public_subnet_tags  = { "Tier" : "public" }
# }

locals {
  cidr            = "10.1.0.0/16"
  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.3.0/24", "10.1.4.0/24", "10.1.5.0/24"]
  region          = "us-west-2"

  resources = {
    wg-prod = "prod-eks"
    wg-qa   = "qa-eks"
    wg-dev  = "dev-eks"
  }
}

# module "my-cluster" {
#   source          = "terraform-aws-modules/eks/aws"
#   for_each        = local.resources
#   cluster_name    = each.value
#   cluster_version = "1.16"
#   subnets         = module.vpc.public_subnets
#   vpc_id          = module.vpc.vpc_id
#   worker_groups = [
#     {
#       name          = each.key
#       instance_type = "m4.large"
#       asg_max_size  = 3
#     }
#   ]

#   depends_on = [module.bucket_deploy]
# }




# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = module.vpc.vpc_id
# }


# output "public_subnets" {
#   description = "List of IDs of public subnets"
#   value       = module.vpc.public_subnets
# }