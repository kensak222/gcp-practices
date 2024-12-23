### mattermost-k8s/modules/vpc/subnets.tf
# 複数のサブネットを用途ごとに分けて、セキュリティを向上
resource "google_compute_subnetwork" "app_subnet" {
  name          = "app-subnet"
  region        = var.region
  network       = google_compute_network.mattermost_vpc.id
  ip_cidr_range = "10.0.64.0/24"
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db-subnet"
  region        = var.region
  network       = google_compute_network.mattermost_vpc.id
  ip_cidr_range = "10.0.65.0/24"
}

