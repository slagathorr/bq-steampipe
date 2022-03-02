resource "google_compute_network" "steampipe_network" {
  auto_create_subnetworks = false
  mtu                     = 1460
  name                    = "steampipe-network"
  project                 = "sada-prj-carbon-analysis"
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "steampipe_subnet_us_central1" {
  ip_cidr_range              = "10.2.0.0/16"
  name                       = "steampipe-subnet-us-central1"
  network                    = google_compute_network.steampipe_network.name
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = var.var_gcp_project_id
  purpose                    = "PRIVATE"
  region                     = "us-central1"
  stack_type                 = "IPV4_ONLY"
}

resource "google_compute_firewall" "default_allow_ssh_steampipe" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "default-allow-ssh-steampipe"
  network       = google_compute_network.steampipe_network.name
  priority      = 65534
  project       = var.var_gcp_project_id
  source_ranges = ["0.0.0.0/0"]
}