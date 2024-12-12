resource "google_sql_database_instance" "mattermost" {
  name             = "mattermost-db"
  region           = var.region
  database_version = "POSTGRES_13"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "mattermost"
  instance = google_sql_database_instance.mattermost.name
  password = var.sql_user_password
}
