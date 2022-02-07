# Service account that Steampipe will use to access Google APIs
resource "google_service_account" "steampipe_svc_account" {
  account_id   = var.var_steampipe_svc_account_name
  display_name = "sa - Steampipe Viewer Service"
}
