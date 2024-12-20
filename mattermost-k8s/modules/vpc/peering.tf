### mattermost-k8s/modules/vpc/peering.tf
# VPCとCloud SQL間でVPC Peeringを構成
# Service Networking Connectionのために指定されたIP範囲がネットワークに存在しないため、Cloud SQLとVPCの接続が失敗する
# そのため、Service Networking用にIP範囲を予約してから、接続を作成する必要がある
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "google-managed-services-${var.region}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.mattermost_vpc.id
}

resource "google_service_networking_connection" "vpc_connection" {
  network                 = google_compute_network.mattermost_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

