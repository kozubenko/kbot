module "gke_cluster" {
  source = "github.com/den-vasyliev/tf-google-gke-cluster"

  GOOGLE_PROJECT   = "infrastructure-demo-project"
  GKE_CLUSTER_NAME = "demo"
  GKE_NUM_NODES    = 2
}
module "tls_private_key" {
  source    = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}
module "github_repository" {
  source = "github.com/den-vasyliev/tf-github-repository"

  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "flux_bootstrap" {
  source = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap?ref=gke_auth"

  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"

  private_key  = module.tls_private_key.private_key_pem
  github_token = var.GITHUB_TOKEN

  config_host  = module.gke_cluster.config_host
  config_token = module.gke_cluster.config_token
  config_ca    = module.gke_cluster.config_ca
}