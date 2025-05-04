module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.project_name
  cluster_version = "1.28"
  subnet_ids      = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    worker-group-1 = {
      instance_types         = ["t2.small"]
      desired_size           = 2
      min_size               = 1
      max_size               = 3
      vpc_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      disk_size              = 20
    }
    worker-group-2 = {
      instance_types         = ["t2.medium"]
      desired_size           = 1
      min_size               = 1
      max_size               = 2
      vpc_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      disk_size              = 20
    }
  }
}
