# Be sure to create a variables file if you want to override the defaults.
# Here is an example: 
#   https://github.com/GoogleCloudPlatform/cloud-builders-community/blob/master/packer/examples/gce/variables.pkrvars.hcl
# Edit the ../runall.sh to include your variables file. The script assumes a file called
# variables.pkvars.hcl to be included in this (../packer) path, so if you make a different file,
# be sure to change runall.sh to reflect that.
# packer build -var-file=[MYVARSFILE.hcl] steampipe.pkr.hcl

variable "project_id" {
  type = string
}

variable "zone" {
  type = string
  default = "us-central1-a"
}

variable "account_file" {
  type    = string
  default = "${env("GOOGLE_APPLICATION_CREDENTIALS")}"
}

variable "subnetwork" {
  type    = string
  default = "default"
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "steampipe" {
  account_file      = "${var.account_file}"
  image_description = "Steampipe service machine."
  image_labels = {
    developer = "supercoolsteampipedev"
    team      = "carbon"
  }
  image_name              = "steampipe-service-v1"
  network                 = "default"
  project_id              = var.project_id
  source_image_family     = "debian-10"
  ssh_username            = "steampipe"
  subnetwork              = var.subnetwork
  zone                    = var.zone
  tags                    = ["packer", "steampipe"]
}

build {
  sources = ["source.googlecompute.steampipe"]

  provisioner "shell" {
    script = "deploy.sh"
  }

}
