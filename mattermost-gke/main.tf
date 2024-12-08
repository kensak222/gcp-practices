# 全体のリソースを構築する中核となる設定ファイル
provider "google" {
  project = var.project_id
  region  = var.region
}

# Kubernetesクラスターモジュール
module "gke" {
  source = "./modules/gke"
  region  = var.region
}

# Cloud SQLモジュール
module "cloud_sql" {
  source = "./modules/cloud_sql"
  region  = var.region
}

# Cloud Storageモジュール
module "storage" {
  source = "./modules/storage"
  region  = var.region
}

# ロードバランサーモジュール
module "load_balancer" {
  source = "./modules/load_balancer"
}

# DNSモジュール
module "dns" {
  source = "./modules/dns"
}
