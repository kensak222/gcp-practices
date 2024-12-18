module "gke" {
  source = "./modules/gke"
  region  = var.region
  project_id  = var.project_id
  sql_user_password = var.sql_user_password
}

module "sql" {
  source = "./modules/sql"
  region  = var.region
  sql_user_password = var.sql_user_password
}

module "storage" {
  source = "./modules/storage"
  region  = var.region
  project_id  = var.project_id
}

module "firewall" {
  source       = "./modules/firewall"
  network_name = "default"
  target_tags  = ["mattermost-cluster"]
}
