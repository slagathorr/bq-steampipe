# Service account that Steampipe will use to access Google APIs
resource "google_service_account" "steampipe_svc_account" {
  account_id   = var.var_steampipe_svc_account_name
  display_name = "sa - Steampipe Viewer Service"
}

resource "google_secret_manager_secret" "steampipe-sa-secret" {
    secret_id   = "steampipe-sa-secret"

    replication {
        automatic = true
    }

    depends_on  = [google_project_service.secretmanager_api]
}

