module "eks-cluster" {
  source                  = "./modules/eks"
  subnet_ids              = aws_subnet.dmz_public.*.id
  security_group_ids     = [aws_security_group.cluster_sg.id]
  node_subnets_ids        = aws_subnet.clusterprivate.*.id
  endpoint_private_access = true
  node_group_name         = "test-cluster"
  launch_template_id      = aws_launch_template.cluster_conf.id
  launch_template_version = aws_launch_template.cluster_conf.latest_version
  desired_size            = 1
  max_size                = 5
  min_size                = 1
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

# We will use ServiceAccount to connect to K8S Cluster in CI/CD mode
# ServiceAccount needs permissions to create deployments 
# and services in default namespace
resource "kubernetes_cluster_role_binding" "example" {
  metadata {
    name = "fabric8-rbac"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "default"
  }
}