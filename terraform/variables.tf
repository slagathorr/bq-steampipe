variable "var_gcp_project_id" {
    description = "Google Cloud project ID"
    type        = string
}

variable "var_gcp_region" {
    description = "Google Cloud region"
    type        = string
    default     = "us-central1"
}

variable "var_steampipe_svc_account_name" {
    description = "Service account ID"
    type        = string
}