resource "google_container_cluster" "primary" {
  name     = "mattermost-cluster"
  location = var.region
  deletion_protection = false

  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20
  }

    timeouts {
    create = "60m"   # クラスター作成のタイムアウトを60分に延長
    update = "60m"   # クラスター更新のタイムアウトを60分に延長
  }
}
