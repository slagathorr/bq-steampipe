# Deleting a Cloud SQL instance means you can't make a new one with the same name for one week
# so we add a random suffix.
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# CloudSQL for Postgres Passthrough
resource "google_sql_database_instance" "steampipe_postgres" {
  name              = "steampipe-postgres-${random_id.db_name_suffix.hex}"
  database_version  = "POSTGRES_13"
  region            = var.var_gcp_region
  project           = var.var_gcp_project_id

  settings {
    # Second-generation instance tiers are based on the machine type.
    tier        = "db-custom-1-3840"
    disk_size   = 20
    disk_type   = "PD_HDD"

    # This code assumes you are using the Google Cloud default network.
    # Please see documentation on setting up and using a different network
    # if you don't want to use the default network.
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
    ip_configuration {
        allocated_ip_range  = "default-ip-range"
        ipv4_enabled        = true
        private_network     = "projects/${var.var_gcp_project_id}/global/networks/default"
    }
  }
  
  #change me later
  deletion_protection = false
}