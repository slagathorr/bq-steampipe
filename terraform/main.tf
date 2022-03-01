resource "random_id" "instance_id" {
 byte_length = 8
}

resource "google_compute_instance" "steampipe-server" {
  name         = "steampipe-svc-${random_id.instance_id.hex}"
  machine_type = "e2-standard-2"
  zone         = var.var_gcp_zone

  boot_disk {
    initialize_params {
      image = "projects/${var.var_gcp_project_id}/global/images/steampipe-service-v1"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = "su - steampipe -c 'steampipe service start'"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.steampipe_svc_account.email
    scopes = ["cloud-platform"]
  }
}