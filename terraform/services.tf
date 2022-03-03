# This entire file includes the APIs needed to spin up the right resources.

resource "google_project_service" "cloudsql_api" {
  service                       = "sql-component.googleapis.com"
  disable_on_destroy            = false
}

resource "google_project_service" "compute_api" {
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "service_networking_api" {
  service = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}