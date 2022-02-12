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

variable "var_steampipe_image_version" {
    description = "Change this in your tfvars file so it matches what's in runall.sh"
    type        = string
    default     = "0.12.2"
}