module "eks-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  for_each        = local.resources
  cluster_name    = each.value
  cluster_version = "1.16"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  worker_groups = [
    {
      name = "spot-1"
      spot_price           = "0.03"
      name                 = each.key
      instance_type        = "t3.large"
      asg_desired_capacity = 1
      asg_max_size         = 3
      # root_volume_type     = "gp2"
      tags = [{
        key                 = "worker-group-tag"
        value               = "worker-group=1"
        propagate_at_launch = true
      }]
    },
    {
      name = "spot-2"
      spot_price           = "0.04"
      name                 = each.key
      instance_type        = "r5.large"
      asg_desired_capacity = 1
      asg_max_size         = 3
      tags = [{
        key                 = "worker-group-tag"
        value               = "worker-group=2"
        propagate_at_launch = true
      }]
    }
  ]
  map_users = [{
        # userarn = "arn:aws:iam::AWS_ACCOUNT:user/AWS_USERNAME"
        userarn = local.userarn
        # username = "AWS_USERNAME"
        username = local.username
        groups = ["system:masters"]
  }]
  tags = {
    environment = each.value
  }

  # depends_on = [module.bucket_deploy]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks-cluster["pp-wg-prod"].cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-cluster["pp-wg-prod"].cluster_id
}