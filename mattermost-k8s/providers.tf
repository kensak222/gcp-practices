provider "google" {
  project = "mattermost-kenken-k8s"
  region  = "us-central1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
