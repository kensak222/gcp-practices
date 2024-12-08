resource "google_sql_database_instance" "instance" {
  name             = "mattermost-gke-db"
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "mattermost"
  instance = google_sql_database_instance.instance.name
  password = "your-secure-password"
}
