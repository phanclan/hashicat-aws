provider "aws" {
  region = local.region
}

terraform {
  required_version = ">=0.13.0"
}

locals {
  cidr            = "10.1.0.0/16"
  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.3.0/24", "10.1.4.0/24", "10.1.5.0/24"]
  region          = "us-west-2"
  spot_price      = "0.20"
  instance_type   = "m5.large"
  userarn         = "arn:aws:iam::753646501470:user/pphan"
  username        = "pphan"

  resources = {
    pp-wg-prod = "phan-prod-eks"
    # wg-qa   = "qa-eks"
    # wg-dev  = "dev-eks"
  }
}