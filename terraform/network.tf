# Main Network
resource "google_compute_network" "steampipe_network" {
  auto_create_subnetworks = false
  mtu                     = 1460
  name                    = "steampipe-network"
  project                 = "sada-prj-carbon-analysis"
  routing_mode            = "REGIONAL"
}

# IP range for Cloud SQL.
resource "google_compute_global_address" "steampipe_postgres_ip_range" {
  address       = "10.196.128.0"
  address_type  = "INTERNAL"
  name          = "steampipe-postgres-ip-range"
  network       = google_compute_network.steampipe_network.name
  prefix_length = 20
  project       = var.var_gcp_project_id
  purpose       = "VPC_PEERING"

  depends_on = [google_compute_network.steampipe_network]
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

resource "google_service_networking_connection" "steampipe_service_networking" {
    network = google_compute_network.steampipe_network.id
    service = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [google_compute_global_address.steampipe_postgres_ip_range.name]
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

resource "google_compute_firewall" "default_allow_internal_steampipe" {
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  description   = "Allow internal traffic on the steampipe network"
  direction     = "INGRESS"
  name          = "default-allow-internal-steampipe"
  network       = google_compute_network.steampipe_network.name
  priority      = 65534
  project       = var.var_gcp_project_id
  source_ranges = ["10.2.0.0/16"]
}

resource "google_compute_firewall" "allow_steampipe_steampipe" {
  allow {
    ports    = ["9193"]
    protocol = "tcp"
  }
  description   = "Allow internal traffic on the steampipe network"
  direction     = "INGRESS"
  name          = "allow-steampipe-steampipe"
  network       = google_compute_network.steampipe_network.name
  priority      = 1000
  project       = var.var_gcp_project_id
  source_ranges = ["10.196.128.0/20"]
}