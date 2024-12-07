resource "google_compute_network" "vpc_network" {
  name = "main-network"
}

# CloudRunからVPC内にアクセスするために必要なVPC Access Connectorを作成
# VPC Access Connectorは、VPC Network内の10.20.0.0/28というIPアドレス範囲をConnectorに割り当てる
resource "google_vpc_access_connector" "connector" {
  name          = "vpc-con"
  ip_cidr_range = "10.20.0.0/28"
  network       = google_compute_network.vpc_network.id
}
