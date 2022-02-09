# Steampipe needs certain IAM permissions to access the Cloud APIs in order to retrieve data.
# This is a custom role built for that purpose, which we can attach to any compute resources that
# is hosting the Steampipe service itself.
resource "google_project_iam_custom_role" "steampipe_custom_role" {
  role_id     = "steampipeViewer"
  title       = "Steampipe Resoource Viewer"
  description = "Custom role for viewing resources for access from the Steampipe service."
  permissions = ["logging.sinks.list", "logging.buckets.list", "logging.exclusions.list", "logging.logMetrics.list"]
}

# Binding the custom role to the Service Account for the host project. Be sure to attach this role to any other project
# that you want Steampipe to be able to pull metadata from.
resource "google_project_iam_binding" "steampipe_svc_account_custom_role_binding" {
    role = "projects/${var.var_gcp_project_id}/roles/${google_project_iam_custom_role.steampipe_custom_role.role_id}"
    project = var.var_gcp_project_id

    members = ["serviceAccount:${google_service_account.steampipe_svc_account.email}"]
}

# Binding the Cloud Assets Viewer role to the Service Account for the host project. Be sure to attach this role to any other project
# that you want Steampipe to be able to pull metadata from.
resource "google_project_iam_binding" "steampipe_svc_account_cloudasset_viewer" {
    role = "roles/cloudasset.viewer"
    project = var.var_gcp_project_id

    members = ["serviceAccount:${google_service_account.steampipe_svc_account.email}"]
}

# Binding the Compute Viewer role to the Service Account for the host project. Be sure to attach this role to any other project
# that you want Steampipe to be able to pull metadata from.
resource "google_project_iam_binding" "steampipe_svc_account_compute_viewer" {
    role = "roles/compute.viewer"
    project = var.var_gcp_project_id

    members = ["serviceAccount:${google_service_account.steampipe_svc_account.email}"]
}