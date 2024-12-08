resource "google_storage_bucket" "mattermost_bucket" {
  name     = "mattermost-storage-bucket"
  location = var.region

  uniform_bucket_level_access = true
}
