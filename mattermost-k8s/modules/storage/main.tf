resource "google_storage_bucket" "mattermost_bucket" {
  name          = "mattermost-file-storage-${var.project_id}"
  location      = var.region
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
