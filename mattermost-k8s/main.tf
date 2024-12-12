module "gke" {
  source = "./modules/gke"
  region  = var.region
}

module "sql" {
  source = "./modules/sql"
  region  = var.region
  sql_user_password = var.sql_user_password
}

module "storage" {
  source = "./modules/storage"
}
