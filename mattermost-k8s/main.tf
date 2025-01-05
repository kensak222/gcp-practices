### mattermost-k8s/main.tf
module "gke" {
  source               = "./modules/gke"
  region               = var.region
  project_id           = var.project_id
  sql_user_password    = var.sql_user_password
  gke_service_account  = var.gke_service_account
  network_id           = module.vpc.vpc_network_id
  mattermost_subnet_id = module.vpc.mattermost_subnet_id
}

module "sql" {
  source            = "./modules/sql"
  region            = var.region
  sql_user_password = var.sql_user_password
}

module "storage" {
  source              = "./modules/storage"
  region              = var.region
  project_id          = var.project_id
  gke_service_account = var.gke_service_account
}

module "firewall" {
  source      = "./modules/firewall"
  network_id  = module.vpc.vpc_network_id
  target_tags = ["mattermost-cluster"]
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "logging" {
  source                   = "./modules/logging"
  project_id               = var.project_id
  service_account_key_path = var.logging_service_account_key_path
}

module "monitoring" {
  source     = "./modules/monitoring"
  project_id = var.project_id
}
