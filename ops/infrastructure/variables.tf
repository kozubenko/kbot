variable "GOOGLE_PROJECT" {
  description = "The GCP project ID where the GKE cluster will be created"
  type        = string
  default     = "infrastructure-demo-project"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "GKE_NUM_NODES" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 1
}

variable "GKE_CLUSTER_NAME" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "kbot"
}

variable "GITHUB_OWNER" {
  description = "GitHub organization or username that owns the repository"
  type        = string
}

variable "GITHUB_TOKEN" {
  description = "GitHub personal access token with repo permissions"
  type        = string
  sensitive   = true
}

variable "FLUX_GITHUB_REPO" {
  description = "The GitHub repository name for Flux bootstrap"
  type        = string
  default     = "flux-gitops"
}
