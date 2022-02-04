# Specify the provider
provider "google" {
    project         = var.var_gcp_project_id
    region          = var.var_gcp_region
}

# CloudSQL for Postgres Passthrough
resource "google_sql_database_instance" "steampipe_postgres" {
  name              = "steampipe-postgres"
  database_version  = "POSTGRES_13"
  region            = "us-central1"
  project           = var.var_gcp_project_id

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-custom-1-3840"
  }
  
  #change me later
  deletion_protection = false
}

# Service account that Steampipe will use to access Google APIs
resource "google_service_account" "steampipe_svc_account" {
  account_id   = var.var_steampipe_svc_account_name
  display_name = "Service Account"
}