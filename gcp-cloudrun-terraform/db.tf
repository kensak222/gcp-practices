resource "google_sql_database_instance" "main" {
  project          = var.project_id
  name             = "main-db"
  region           = "us-west1"
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      private_network = google_compute_network.vpc_network.id
      # Public IPを持たない、Private IPのみCloudSQLを作成するため、ipv4_enabledはfalse
      ipv4_enabled    = false
    }
  }
}
