variable "deploy_env" {
  type    = list(string)
  default = ["prod", "qa", "dev"]
}

## Module level count argument and depends_on vpc module.
# module "s3_bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"
#   #v0.12 did not support count at this level.
#   count  = length(var.deploy_env)
#   region = "us-west-2"
#   bucket = "s3-20200706-${var.deploy_env[count.index]}"

#   #new with v0.13
#   depends_on = [module.vpc]
# }