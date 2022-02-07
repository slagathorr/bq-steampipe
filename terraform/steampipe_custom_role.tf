resource "google_project_iam_custom_role" "steampipe_custom_role" {
  role_id     = "steampipeViewer"
  title       = "Steampipe Resoource Viewer"
  description = "Custom role for viewing resources for access from the Steampipe service."
  permissions = ["compute.instances.list", "compute.instances.getIamPolicy"]
}

resource "google_project_iam_binding" "steampipe_svc_account_custom_role_binding" {
    role = "projects/${var.var_gcp_project_id}/roles/${google_project_iam_custom_role.steampipe_custom_role.role_id}"
    project = var.var_gcp_project_id

    members = ["serviceAccount:${google_service_account.steampipe_svc_account.email}"]
}