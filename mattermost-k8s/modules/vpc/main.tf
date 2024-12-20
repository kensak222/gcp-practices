### mattermost-k8s/modules/vpc/main.tf
# 専用のVPCネットワークを作成
resource "google_compute_network" "mattermost_vpc" {
  name                    = "mattermost-vpc"
  auto_create_subnetworks = false
  description             = "Custom VPC for Mattermost deployment"
}

# 専用のサブネットを作成し、GKEクラスタなどその他リソースに割り当てる
resource "google_compute_subnetwork" "mattermost_subnet" {
  name          = "mattermost-subnet"
  region        = var.region
  network       = google_compute_network.mattermost_vpc.id
  ip_cidr_range = "10.0.0.0/18"

  # GKEクラスタのip_allocation_policyで指定しているcluster_secondary_range_nameと
  # services_secondary_range_nameを、VPCネットワークやサブネットで定義する必要がある
  # GKE用のサブネットを作成し、Pod用とService用のIP範囲を設定
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.2.0.0/20"
  }
}

# Cloud Routerの作成
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  region  = var.region
  network = google_compute_network.mattermost_vpc.id
}

# Cloud NATの作成
# プライベートクラスタでは、Nodeに外部IPがないため、コンテナイメージのプルに
# 問題が出ることがあるため、NATを設定（不要かもしれないが未検証！！）
resource "google_compute_router_nat" "nat" {
  name                               = "nat-config"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
