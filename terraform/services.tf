# This entire file includes the APIs needed to spin up the right resources.

resource "google_project_service" "cloudsql_api" {
  project                       = var.var_gcp_project_id
  service                       = "sql-component.googleapis.com"
  disable_dependent_services    = true
  disable_on_destroy            = true
}