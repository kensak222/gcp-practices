### mattermost-k8s/modules/storage/main.tf
resource "google_storage_bucket" "mattermost_bucket" {
  name          = "mattermost-file-storage-${var.project_id}"
  location      = var.region
  # 低性能なものを指定しているが、本稼働では高性能にすること
  storage_class = "NEARLINE"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 90
    }
  }

  force_destroy = true
}

# バケットへのアクセスを最小権限で制御し、パブリックアクセスを防
resource "google_storage_bucket_iam_member" "mattermost_bucket_admin" {
  bucket = google_storage_bucket.mattermost_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.gke_service_account}"
}
