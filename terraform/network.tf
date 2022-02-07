# This code assumes you are using the Google Cloud default network.
# Please see documentation on setting up and using a different network
# if you don't want to use the default network.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance    
#resource "google_compute_global_address" "steampipe_cloud_sql_private_ip_address" {
#    name            = "steampipe-cloud-sql-private-ip-address"
#    address_type    = "INTERNAL"
#    prefix_length   = 16
#    network         = "default"
#    purpose         = "VPC_PEERING"
#}