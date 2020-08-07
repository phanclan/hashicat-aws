data "aws_availability_zones" "available" {}

module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "phan-vpc-uw2-frontend"
  cidr                 = local.cidr
  azs                  = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  public_subnets       = local.public_subnets
  private_subnets      = local.private_subnets
  enable_dns_hostnames = true #required for EKS
  enable_dns_support   = true #required for EKS
  enable_nat_gateway   = true #for worker nodes
  single_nat_gateway   = true #for worker nodes
  # tags                     = local.common_tags
  # igw_tags                 = { Name = "${var.prefix}-${var.env}-usw2-1-IGW" }
  # nat_gateway_tags         = { Name = "${var.prefix}-${var.env}-usw2-1-NGW" }
  # public_route_table_tags  = { Name = "${var.prefix}-${var.env}-usw2-1-RT-public" }
  # public_subnet_tags       = { Name = "${var.prefix}-${var.env}-usw2-1-public" }
  # private_route_table_tags = { Name = "${var.prefix}-${var.env}-usw2-1-RT-private" }
  # private_subnet_tags      = { Name = "${var.prefix}-${var.env}-usw2-1-private" }
  private_subnet_tags = {
    "Tier" : "private"
    "kubernetes.io/cluster/pp-wg-prod" = "shared" #required for EKS
    "kubernetes.io/role/internal-elb"  = 1        #required for EKS
  }
  public_subnet_tags = {
    "Tier" : "public"
    # "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/cluster/pp-wg-prod" = "shared" #required for EKS
    "kubernetes.io/role/elb"           = 1        #required for EKS
  }
}