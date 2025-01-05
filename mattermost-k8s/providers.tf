### providers.tf
provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.gke_service_account_key_path)
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
