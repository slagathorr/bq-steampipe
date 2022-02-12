resource "google_artifact_registry_repository" "steampipe-images" {
  provider = google-beta

  location = "us-central1"
  repository_id = "steampipe-repo"
  description = "Steampipe Images"
  format = "DOCKER"
  project = var.var_gcp_project_id
}