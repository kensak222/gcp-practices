module "gke" {
  source = "./modules/gke"
  region  = var.region
}

module "sql" {
  source = "./modules/sql"
  region  = var.region
}

module "storage" {
  source = "./modules/storage"
}
