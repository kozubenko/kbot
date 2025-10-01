output "cluster_name" {
  value = module.gke_cluster.name
}

output "external_ip" {
  value = module.gke_cluster.config_host
}