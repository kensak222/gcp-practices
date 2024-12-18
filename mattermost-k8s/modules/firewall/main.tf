resource "google_compute_firewall" "allow_https" {
  name        = var.firewall_name
  description = "Allow HTTPS traffic"
  network     = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = var.target_tags
}
