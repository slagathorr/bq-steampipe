resource "google_artifact_registry_repository" "steampipe" {
  format        = "DOCKER"
  location      = "us-central1"
  project       = "sada-prj-carbon-analysis"
  repository_id = "steampipe"
}
# terraform import google_artifact_registry_repository.steampipe projects/sada-prj-carbon-analysis/locations/us-central1/repositories/steampipe
resource "google_bigquery_dataset" "carbon_export_all" {
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "OWNER"
    user_by_email = "tanya.leung@sada.com"
  }
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
  access {
    role          = "WRITER"
    user_by_email = "service-1060261191865@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"
  }
  dataset_id                 = "carbon_export_all"
  delete_contents_on_destroy = false
  location                   = "US"
  project                    = "sada-prj-carbon-analysis"
}
# terraform import google_bigquery_dataset.carbon_export_all projects/sada-prj-carbon-analysis/datasets/carbon_export_all
resource "google_bigquery_dataset" "carbon_export" {
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "OWNER"
    user_by_email = "tanya.leung@sada.com"
  }
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
  access {
    role          = "WRITER"
    user_by_email = "service-1060261191865@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"
  }
  dataset_id                 = "carbon_export"
  delete_contents_on_destroy = false
  description                = "Dataset where carbon offset data is exported to"
  location                   = "US"
  project                    = "sada-prj-carbon-analysis"
}
# terraform import google_bigquery_dataset.carbon_export projects/sada-prj-carbon-analysis/datasets/carbon_export
resource "google_bigquery_dataset" "suk_carbon_export_test" {
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "OWNER"
    user_by_email = "brian.suk@sada.com"
  }
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
  access {
    role          = "WRITER"
    user_by_email = "service-1060261191865@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"
  }
  dataset_id                 = "suk_carbon_export_test"
  delete_contents_on_destroy = false
  location                   = "US"
  project                    = "sada-prj-carbon-analysis"
}
# terraform import google_bigquery_dataset.suk_carbon_export_test projects/sada-prj-carbon-analysis/datasets/suk_carbon_export_test
resource "google_bigquery_table" "carbon_footprint_export" {
  dataset_id  = "carbon_export"
  description = "Carbon footprint data from Google Cloud usage for the requested billing account.\n"
  project     = "sada-prj-carbon-analysis"
  schema      = "[{\"description\":\"Month during which this usage occurred.\\n\",\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"description\":\"Billing account ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"description\":\"Project for this usage.\\n\",\"fields\":[{\"description\":\"Project number for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"description\":\"Project ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"description\":\"Service for this usage.\\n\",\"fields\":[{\"description\":\"Cloud Billing service ID for the service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"description\":\"Display name for this service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"description\":\"Location for this usage.\\n\",\"fields\":[{\"description\":\"Cloud location for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"description\":\"Cloud region for this usage. NULL if usage is multi-regional or global.\\n\",\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"description\":\"Gross carbon footprint (kg CO2e) in the specified location and partition date.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"description\":\"Version of carbon model that produced this output.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id    = "carbon_footprint_export"
}
# terraform import google_bigquery_table.carbon_footprint_export projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/carbon_footprint_export
resource "google_bigquery_table" "all_billing_data" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"fields\":[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"}],\"name\":\"service\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"}],\"name\":\"sku\",\"type\":\"RECORD\"},{\"name\":\"usage_start_time\",\"type\":\"TIMESTAMP\"},{\"name\":\"usage_end_time\",\"type\":\"TIMESTAMP\"},{\"fields\":[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"number\",\"type\":\"STRING\"},{\"name\":\"name\",\"type\":\"STRING\"},{\"fields\":[{\"name\":\"key\",\"type\":\"STRING\"},{\"name\":\"value\",\"type\":\"STRING\"}],\"mode\":\"REPEATED\",\"name\":\"labels\",\"type\":\"RECORD\"},{\"name\":\"ancestry_numbers\",\"type\":\"STRING\"}],\"name\":\"project\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"key\",\"type\":\"STRING\"},{\"name\":\"value\",\"type\":\"STRING\"}],\"mode\":\"REPEATED\",\"name\":\"labels\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"key\",\"type\":\"STRING\"},{\"name\":\"value\",\"type\":\"STRING\"}],\"mode\":\"REPEATED\",\"name\":\"system_labels\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"country\",\"type\":\"STRING\"},{\"name\":\"region\",\"type\":\"STRING\"},{\"name\":\"zone\",\"type\":\"STRING\"}],\"name\":\"location\",\"type\":\"RECORD\"},{\"name\":\"export_time\",\"type\":\"TIMESTAMP\"},{\"name\":\"cost\",\"type\":\"FLOAT\"},{\"name\":\"currency\",\"type\":\"STRING\"},{\"name\":\"currency_conversion_rate\",\"type\":\"FLOAT\"},{\"fields\":[{\"name\":\"amount\",\"type\":\"FLOAT\"},{\"name\":\"unit\",\"type\":\"STRING\"},{\"name\":\"amount_in_pricing_units\",\"type\":\"FLOAT\"},{\"name\":\"pricing_unit\",\"type\":\"STRING\"}],\"name\":\"usage\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"name\",\"type\":\"STRING\"},{\"name\":\"amount\",\"type\":\"FLOAT\"},{\"name\":\"full_name\",\"type\":\"STRING\"},{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"type\",\"type\":\"STRING\"}],\"mode\":\"REPEATED\",\"name\":\"credits\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"month\",\"type\":\"STRING\"}],\"name\":\"invoice\",\"type\":\"RECORD\"},{\"name\":\"cost_type\",\"type\":\"STRING\"},{\"fields\":[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"},{\"name\":\"mode\",\"type\":\"STRING\"},{\"name\":\"type\",\"type\":\"STRING\"}],\"name\":\"adjustment_info\",\"type\":\"RECORD\"},{\"name\":\"pstDate\",\"type\":\"DATE\"},{\"name\":\"partitionDate\",\"type\":\"DATE\"},{\"name\":\"resellerConsole\",\"type\":\"STRING\"}]"
  table_id   = "all_billing_data"
  view {
    query          = "SELECT *\nFROM `corp-skyrise.gcpBillingExports.gcpBillingUnion`"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.all_billing_data projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/all_billing_data
resource "google_bigquery_dataset" "cloud_asset_inventory" {
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "OWNER"
    user_by_email = "gina.huh@sada.com"
  }
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
  dataset_id                 = "cloud_asset_inventory"
  delete_contents_on_destroy = false
  location                   = "US"
  project                    = "sada-prj-carbon-analysis"
}
# terraform import google_bigquery_dataset.cloud_asset_inventory projects/sada-prj-carbon-analysis/datasets/cloud_asset_inventory
resource "google_bigquery_dataset" "projects_invoice" {
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "OWNER"
    user_by_email = "gina.huh@sada.com"
  }
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
  dataset_id                 = "projects_invoice"
  delete_contents_on_destroy = false
  location                   = "US"
  project                    = "sada-prj-carbon-analysis"
}
# terraform import google_bigquery_dataset.projects_invoice projects/sada-prj-carbon-analysis/datasets/projects_invoice
resource "google_bigquery_table" "neustar_footprint" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"usage_month\",\"type\":\"DATE\"},{\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"fields\":[{\"name\":\"number\",\"type\":\"STRING\"},{\"name\":\"id\",\"type\":\"STRING\"}],\"name\":\"project\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"}],\"name\":\"service\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"region\",\"type\":\"STRING\"}],\"name\":\"location\",\"type\":\"RECORD\"},{\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id   = "neustar_footprint"
  view {
    query          = "SELECT *\nFrom carbon_export_all.carbon_footprint_export\nWHERE billing_account_id = '018CA2-7A06B1-E2169E'"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.neustar_footprint projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/neustar_footprint
resource "google_bigquery_table" "find_rank_by_cost" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"project_id\",\"type\":\"STRING\"},{\"name\":\"total_cost\",\"type\":\"FLOAT\"},{\"name\":\"rank\",\"type\":\"INTEGER\"}]"
  table_id   = "find_rank_by_cost"
  view {
    query          = "WITH\n  rank_tb AS (\n  WITH\n    total_cost_tb AS (\n    SELECT\n      project.id AS project_id,\n      ROUND(SUM(cost),2) AS total_cost\n    FROM\n      `corp-skyrise.gcpBillingExports.gcpBillingUnion`\n    GROUP BY\n      project.id\n    ORDER BY\n      total_cost DESC)\n  SELECT\n    project_id,\n    total_cost,\n    DENSE_RANK() OVER(ORDER BY total_cost DESC) AS rank,\n  FROM\n    total_cost_tb\n  ORDER BY\n    rank ASC)\nSELECT\n  project_id,\n  total_cost,\n  rank\nFROM\n  rank_tb\nWHERE\n  project_id = 'sada-gke-on-prem-demo'"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.find_rank_by_cost projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/find_rank_by_cost
resource "google_bigquery_dataset" "dt_neustar_carbon_export" {
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "OWNER"
    user_by_email = "gina.huh@sada.com"
  }
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
  access {
    role          = "WRITER"
    user_by_email = "service-1060261191865@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"
  }
  dataset_id                 = "dt_neustar_carbon_export"
  delete_contents_on_destroy = false
  location                   = "US"
  project                    = "sada-prj-carbon-analysis"
}
# terraform import google_bigquery_dataset.dt_neustar_carbon_export projects/sada-prj-carbon-analysis/datasets/dt_neustar_carbon_export
resource "google_bigquery_table" "digital_turbine_footprint" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"usage_month\",\"type\":\"DATE\"},{\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"fields\":[{\"name\":\"number\",\"type\":\"STRING\"},{\"name\":\"id\",\"type\":\"STRING\"}],\"name\":\"project\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"}],\"name\":\"service\",\"type\":\"RECORD\"},{\"fields\":[{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"region\",\"type\":\"STRING\"}],\"name\":\"location\",\"type\":\"RECORD\"},{\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id   = "digital_turbine_footprint"
  view {
    query          = "SELECT * \nFrom carbon_export_all.carbon_footprint_export\nWHERE billing_account_id in ('0142A3-94EDDA-E80EB2','01766F-1BA01B-00E5D0')"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.digital_turbine_footprint projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/digital_turbine_footprint
resource "google_bigquery_table" "percentage_cost_by_service" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"project_id\",\"type\":\"STRING\"},{\"name\":\"service\",\"type\":\"STRING\"},{\"name\":\"percentage\",\"type\":\"FLOAT\"}]"
  table_id   = "percentage_cost_by_service"
  view {
    query          = "with cost as (\nSELECT project.id as project_id, service.description as service, sum(cost) as total_cost\nFROM `corp-skyrise.gcpBillingExports.gcpBillingUnion`\nwhere project.id = 'sada-gke-on-prem-demo'\ngroup by 1,2\norder by total_cost desc),\ngrand_total as (\nselect project_id, service, total_cost, sum(total_cost) OVER(PARTITION BY project_id) as grand_total\nfrom cost\ngroup by 1,2,3\norder by total_cost desc)\n\nselect distinct cost.project_id, cost.service, ROUND((SAFE_DIVIDE(cost.total_cost, grand.grand_total)*100),2) as percentage\nfrom grand_total as grand, cost\norder by percentage desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.percentage_cost_by_service projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/percentage_cost_by_service
resource "google_bigquery_table" "top_projects_by_footprint" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"project_id\",\"type\":\"STRING\"},{\"name\":\"project_number\",\"type\":\"STRING\"},{\"name\":\"total_carbon_footprint\",\"type\":\"FLOAT\"}]"
  table_id   = "top_projects_by_footprint"
  view {
    query          = "select project.id as project_id, project.number as project_number, ROUND(sum(carbon_footprint_kgCO2e),4) as total_carbon_footprint\nfrom carbon_export.carbon_footprint_export\ngroup by 1,2\norder by total_carbon_footprint desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.top_projects_by_footprint projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/top_projects_by_footprint
resource "google_bigquery_table" "total_footprint_by_service_location" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"project_id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"},{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"total_carbon_footprint\",\"type\":\"FLOAT\"},{\"name\":\"rank\",\"type\":\"INTEGER\"}]"
  table_id   = "total_footprint_by_service_location"
  view {
    query          = "SELECT\n  project.id AS project_id,\n  service.description,\n  location.location,\n  ROUND(sum(carbon_footprint_kgCO2e),4) AS total_carbon_footprint,\n  RANK() OVER(PARTITION BY service.description ORDER BY sum(carbon_footprint_kgCO2e) DESC) AS rank\nFROM\n  carbon_export.carbon_footprint_export\nWHERE\n  project.id = 'sada-gke-on-prem-demo'\n  AND service.description IN (\"Compute Engine\",\n    \"Anthos\",\n    \"Kubernetes Engine\")\nGROUP BY\n  1,\n  2,\n  3\nORDER BY\n  service.description"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_footprint_by_service_location projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_footprint_by_service_location
resource "google_bigquery_table" "top_projects_by_cost" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"project_id\",\"type\":\"STRING\"},{\"name\":\"total_cost\",\"type\":\"FLOAT\"},{\"name\":\"rank\",\"type\":\"INTEGER\"}]"
  table_id   = "top_projects_by_cost"
  view {
    query          = "with total_cost_tb as (\nSELECT project.id as project_id, ROUND(sum(cost),2) as total_cost\nFROM `corp-skyrise.gcpBillingExports.gcpBillingUnion`\ngroup by project.id\norder by total_cost desc)\n\nselect project_id, total_cost, DENSE_RANK() OVER(ORDER BY total_cost desc) as rank,\nfrom total_cost_tb\norder by rank asc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.top_projects_by_cost projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/top_projects_by_cost
resource "google_bigquery_table" "resources" {
  dataset_id = "cloud_asset_inventory"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"mode\":\"NULLABLE\",\"name\":\"name\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"asset_type\",\"type\":\"STRING\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"version\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"discovery_document_uri\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"discovery_name\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"resource_url\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"parent\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"data\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"resource\",\"type\":\"RECORD\"},{\"mode\":\"REPEATED\",\"name\":\"ancestors\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"update_time\",\"type\":\"TIMESTAMP\"}]"
  table_id   = "resources"
}
# terraform import google_bigquery_table.resources projects/sada-prj-carbon-analysis/datasets/cloud_asset_inventory/tables/resources
resource "google_bigquery_table" "total_footprint_by_location_region" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"region\",\"type\":\"STRING\"},{\"name\":\"total_carbon_footprint\",\"type\":\"FLOAT\"}]"
  table_id   = "total_footprint_by_location_region"
  view {
    query          = "select location.location, location.region, ROUND(sum(carbon_footprint_kgCO2e),4) as total_carbon_footprint\nfrom carbon_export.carbon_footprint_export\ngroup by 1,2\norder by total_carbon_footprint desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_footprint_by_location_region projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_footprint_by_location_region
resource "google_bigquery_table" "total_footprint_by_service" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"project_id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"},{\"name\":\"total_carbon_footprint\",\"type\":\"FLOAT\"}]"
  table_id   = "total_footprint_by_service"
  view {
    query          = "select project.id as project_id, service.description, ROUND(sum(carbon_footprint_kgCO2e),4) as total_carbon_footprint\nfrom carbon_export.carbon_footprint_export\nwhere project.id = 'sada-gke-on-prem-demo'\ngroup by 1,2\norder by total_carbon_footprint desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_footprint_by_service projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_footprint_by_service
resource "google_bigquery_table" "total_cost_by_location" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"region\",\"type\":\"STRING\"},{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"total_cost\",\"type\":\"FLOAT\"}]"
  table_id   = "total_cost_by_location"
  view {
    query          = "SELECT location.region, location.location, ROUND(sum(cost),2) as total_cost\nFROM `corp-skyrise.gcpBillingExports.gcpBillingUnion`\nwhere location.region is not Null\ngroup by 1,2\norder by total_cost desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_cost_by_location projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_cost_by_location
resource "google_bigquery_table" "total_footprint_by_month" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"project_id\",\"type\":\"STRING\"},{\"name\":\"project_number\",\"type\":\"STRING\"},{\"name\":\"usage_month\",\"type\":\"DATE\"},{\"name\":\"total_carbon_footprint\",\"type\":\"FLOAT\"}]"
  table_id   = "total_footprint_by_month"
  view {
    query          = "SELECT\n  project.id AS project_id,\n  project.number AS project_number,\n  usage_month,\n  ROUND(SUM(carbon_footprint_kgCO2e),4) AS total_carbon_footprint\nFROM\n  carbon_export.carbon_footprint_export\nWHERE\n  project.id = 'sada-gke-on-prem-demo'\nGROUP BY\n  1,\n  2,\n  3\nORDER BY\n  project_id DESC,\n  usage_month DESC"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_footprint_by_month projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_footprint_by_month
resource "google_bigquery_table" "dt_december" {
  dataset_id = "dt_neustar_carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id   = "dt_december"
}
# terraform import google_bigquery_table.dt_december projects/sada-prj-carbon-analysis/datasets/dt_neustar_carbon_export/tables/dt_december
resource "google_bigquery_table" "top_services_by_footprint" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"description\",\"type\":\"STRING\"},{\"name\":\"total_carbon_footprint\",\"type\":\"FLOAT\"}]"
  table_id   = "top_services_by_footprint"
  view {
    query          = "select service.description, ROUND(sum(carbon_footprint_kgCO2e),4) as total_carbon_footprint\nfrom carbon_export.carbon_footprint_export\ngroup by 1\norder by total_carbon_footprint desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.top_services_by_footprint projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/top_services_by_footprint
resource "google_bigquery_table" "percentage_footprint_by_service" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"service\",\"type\":\"STRING\"},{\"name\":\"percentage\",\"type\":\"FLOAT\"}]"
  table_id   = "percentage_footprint_by_service"
  view {
    query          = "with total_carbon as (\nselect project.id as project_id, service.description as service, ROUND(sum(carbon_footprint_kgCO2e),4) as total_carbon_footprint\nfrom carbon_export.carbon_footprint_export\nwhere project.id = 'sada-gke-on-prem-demo'\ngroup by 1,2\norder by total_carbon_footprint desc),\ngrand_total as (\nselect project_id, service, total_carbon_footprint, sum(total_carbon_footprint) OVER(PARTITION BY project_id) as grand_total\nfrom total_carbon\ngroup by 1,2,3\norder by grand_total desc)\n\nselect distinct carbon.service, ROUND((SAFE_DIVIDE(carbon.total_carbon_footprint, grand.grand_total)*100),4) as percentage\nfrom grand_total as grand, total_carbon as carbon\norder by percentage desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.percentage_footprint_by_service projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/percentage_footprint_by_service
resource "google_bigquery_table" "top_carbon_free_locations" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"cloud_region\",\"type\":\"STRING\"},{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"total_percent_carbon_free\",\"type\":\"FLOAT\"}]"
  table_id   = "top_carbon_free_locations"
  view {
    query          = "SELECT cloud_region, location, sum(google_cfe) as total_percent_carbon_free\nFROM `bigquery-public-data.google_cfe.datacenter_cfe`\nwhere year =  2020 and google_cfe is not null\ngroup by 1,2\norder by total_percent_carbon_free desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.top_carbon_free_locations projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/top_carbon_free_locations
resource "google_bigquery_table" "total_cost_by_service" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"},{\"name\":\"total_cost\",\"type\":\"FLOAT\"}]"
  table_id   = "total_cost_by_service"
  view {
    query          = "SELECT project.id, service.description, ROUND(sum(cost),2) as total_cost\nFROM `corp-skyrise.gcpBillingExports.gcpBillingUnion`\nwhere project.id = 'sada-gke-on-prem-demo'\ngroup by 1,2\norder by total_cost desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_cost_by_service projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_cost_by_service
resource "google_bigquery_table" "neustar_invoice" {
  dataset_id = "projects_invoice"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"mode\":\"NULLABLE\",\"name\":\"Usage_Month\",\"type\":\"DATE\"},{\"mode\":\"NULLABLE\",\"name\":\"Project\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"Project_ID\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"Project_number\",\"type\":\"INTEGER\"},{\"mode\":\"NULLABLE\",\"name\":\"List_cost\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"Negotiated_savings\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"Discounts\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"Promotions_and_others\",\"type\":\"INTEGER\"},{\"mode\":\"NULLABLE\",\"name\":\"Subtotal\",\"type\":\"FLOAT\"}]"
  table_id   = "neustar_invoice"
}
# terraform import google_bigquery_table.neustar_invoice projects/sada-prj-carbon-analysis/datasets/projects_invoice/tables/neustar_invoice
resource "google_compute_disk" "pgtest" {
  image                     = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20220118"
  name                      = "pgtest"
  physical_block_size_bytes = 4096
  project                   = "sada-prj-carbon-analysis"
  size                      = 10
  type                      = "pd-balanced"
  zone                      = "us-central1-a"
}
# terraform import google_compute_disk.pgtest projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/pgtest
resource "google_project" "sada_prj_carbon_analysis" {
  auto_create_network = true
  billing_account     = "013D73-8045B7-7570C0"
  folder_id           = "282399596997"
  name                = "sada-prj-carbon-analysis"
  project_id          = "sada-prj-carbon-analysis"
}
# terraform import google_project.sada_prj_carbon_analysis projects/sada-prj-carbon-analysis
resource "google_bigquery_table" "dt" {
  dataset_id = "dt_neustar_carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id   = "dt"
}
# terraform import google_bigquery_table.dt projects/sada-prj-carbon-analysis/datasets/dt_neustar_carbon_export/tables/dt
resource "google_bigquery_table" "total_cost_by_service_location" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"description\",\"type\":\"STRING\"},{\"name\":\"region\",\"type\":\"STRING\"},{\"name\":\"location\",\"type\":\"STRING\"},{\"name\":\"total_cost\",\"type\":\"FLOAT\"}]"
  table_id   = "total_cost_by_service_location"
  view {
    query          = "SELECT project.id, service.description, location.region, location.location, ROUND(sum(cost),2) as total_cost\nFROM `corp-skyrise.gcpBillingExports.gcpBillingUnion`\nwhere location.region is not Null\ngroup by 1,2,3,4\norder by total_cost desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_cost_by_service_location projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_cost_by_service_location
resource "google_bigquery_table" "carbon_footprint_export" {
  dataset_id  = "suk_carbon_export_test"
  description = "Carbon footprint data from Google Cloud usage for the requested billing account.\n"
  project     = "sada-prj-carbon-analysis"
  schema      = "[{\"description\":\"Month during which this usage occurred.\\n\",\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"description\":\"Billing account ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"description\":\"Project for this usage.\\n\",\"fields\":[{\"description\":\"Project number for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"description\":\"Project ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"description\":\"Service for this usage.\\n\",\"fields\":[{\"description\":\"Cloud Billing service ID for the service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"description\":\"Display name for this service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"description\":\"Location for this usage.\\n\",\"fields\":[{\"description\":\"Cloud location for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"description\":\"Cloud region for this usage. NULL if usage is multi-regional or global.\\n\",\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"description\":\"Gross carbon footprint (kg CO2e) in the specified location and partition date.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"description\":\"Version of carbon model that produced this output.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id    = "carbon_footprint_export"
}
# terraform import google_bigquery_table.carbon_footprint_export projects/sada-prj-carbon-analysis/datasets/suk_carbon_export_test/tables/carbon_footprint_export
resource "google_bigquery_table" "digital_turbine" {
  dataset_id = "projects_invoice"
  external_data_configuration {
    autodetect = false
    google_sheets_options {
      range             = "Digital Turbine for BQ"
      skip_leading_rows = 1
    }
    source_format = "GOOGLE_SHEETS"
    source_uris   = ["https://docs.google.com/spreadsheets/d/1F1A9OUZxCdYLWUjqEN8ReeyyfuVboqBBPhyc9FdZPec/edit#gid=1966624894"]
  }
  project  = "sada-prj-carbon-analysis"
  schema   = "[{\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"project_ID\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"project_number\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"list_cost\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"negotiated_savings\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"discounts\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"promotions_and_others\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"subtotal\",\"type\":\"FLOAT\"}]"
  table_id = "digital_turbine"
}
# terraform import google_bigquery_table.digital_turbine projects/sada-prj-carbon-analysis/datasets/projects_invoice/tables/digital_turbine
resource "google_bigquery_table" "neustar" {
  dataset_id = "projects_invoice"
  external_data_configuration {
    autodetect = false
    google_sheets_options {
      range             = "Neustar for BQ"
      skip_leading_rows = 1
    }
    source_format = "GOOGLE_SHEETS"
    source_uris   = ["https://docs.google.com/spreadsheets/d/1F1A9OUZxCdYLWUjqEN8ReeyyfuVboqBBPhyc9FdZPec/edit#gid=1966624894"]
  }
  project  = "sada-prj-carbon-analysis"
  schema   = "[{\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"project_id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"project_number\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"list_cost\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"negotiated_savings\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"discounts\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"promotions_and_others\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"subtotal\",\"type\":\"FLOAT\"}]"
  table_id = "neustar"
}
# terraform import google_bigquery_table.neustar projects/sada-prj-carbon-analysis/datasets/projects_invoice/tables/neustar
resource "google_compute_disk" "steampipe_svc_7bf274f23697a0a8" {
  image                     = "https://www.googleapis.com/compute/beta/projects/sada-prj-carbon-analysis/global/images/steampipe-service-v1"
  name                      = "steampipe-svc-7bf274f23697a0a8"
  physical_block_size_bytes = 4096
  project                   = "sada-prj-carbon-analysis"
  size                      = 20
  type                      = "pd-standard"
  zone                      = "us-central1-a"
}
# terraform import google_compute_disk.steampipe_svc_7bf274f23697a0a8 projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/steampipe-svc-7bf274f23697a0a8
resource "google_bigquery_table" "carbon_footprint_export" {
  dataset_id  = "carbon_export_all"
  description = "Carbon footprint data from Google Cloud usage for the requested billing account.\n"
  project     = "sada-prj-carbon-analysis"
  schema      = "[{\"description\":\"Month during which this usage occurred.\\n\",\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"description\":\"Billing account ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"description\":\"Project for this usage.\\n\",\"fields\":[{\"description\":\"Project number for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"description\":\"Project ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"description\":\"Service for this usage.\\n\",\"fields\":[{\"description\":\"Cloud Billing service ID for the service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"description\":\"Display name for this service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"description\":\"Location for this usage.\\n\",\"fields\":[{\"description\":\"Cloud location for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"description\":\"Cloud region for this usage. NULL if usage is multi-regional or global.\\n\",\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"description\":\"Gross carbon footprint (kg CO2e) in the specified location and partition date.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"description\":\"Version of carbon model that produced this output.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id    = "carbon_footprint_export"
}
# terraform import google_bigquery_table.carbon_footprint_export projects/sada-prj-carbon-analysis/datasets/carbon_export_all/tables/carbon_footprint_export
resource "google_sql_database_instance" "steampipe_postgres_fa8d4155" {
  database_version = "POSTGRES_13"
  name             = "steampipe-postgres-fa8d4155"
  project          = "sada-prj-carbon-analysis"
  region           = "us-central1"
  settings {
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"
    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
      start_time                     = "15:00"
      transaction_log_retention_days = 7
    }
    disk_autoresize       = true
    disk_autoresize_limit = 0
    disk_size             = 20
    disk_type             = "PD_HDD"
    ip_configuration {
      ipv4_enabled    = true
      private_network = "projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
    }
    location_preference {
      zone = "us-central1-a"
    }
    pricing_plan = "PER_USE"
    tier         = "db-custom-1-3840"
  }
}
# terraform import google_sql_database_instance.steampipe_postgres_fa8d4155 projects/sada-prj-carbon-analysis/instances/steampipe-postgres-fa8d4155
resource "google_compute_disk" "suk_worker_dev" {
  image                     = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20211209"
  name                      = "suk-worker-dev"
  physical_block_size_bytes = 4096
  project                   = "sada-prj-carbon-analysis"
  size                      = 10
  type                      = "pd-balanced"
  zone                      = "us-central1-a"
}
# terraform import google_compute_disk.suk_worker_dev projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/suk-worker-dev
resource "google_compute_firewall" "steampipe" {
  allow {
    ports    = ["9193"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "steampipe"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  priority      = 1000
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["10.115.0.0/24", "30.70.0.0/24", "35.188.212.78/32"]
  target_tags   = ["steampipe-ingress"]
}
# terraform import google_compute_firewall.steampipe projects/sada-prj-carbon-analysis/global/firewalls/steampipe
resource "google_compute_disk" "suk_db_client_test" {
  image                     = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20220118"
  name                      = "suk-db-client-test"
  physical_block_size_bytes = 4096
  project                   = "sada-prj-carbon-analysis"
  size                      = 10
  type                      = "pd-balanced"
  zone                      = "us-central1-a"
}
# terraform import google_compute_disk.suk_db_client_test projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/suk-db-client-test
resource "google_bigquery_table" "neustar" {
  dataset_id = "dt_neustar_carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id   = "neustar"
}
# terraform import google_bigquery_table.neustar projects/sada-prj-carbon-analysis/datasets/dt_neustar_carbon_export/tables/neustar
resource "google_compute_firewall" "default_allow_rdp" {
  allow {
    ports    = ["3389"]
    protocol = "tcp"
  }
  description   = "Allow RDP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-rdp"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  priority      = 65534
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_rdp projects/sada-prj-carbon-analysis/global/firewalls/default-allow-rdp
resource "google_bigquery_table" "carbon_footprint_export" {
  dataset_id  = "dt_neustar_carbon_export"
  description = "Carbon footprint data from Google Cloud usage for the requested billing account.\n"
  project     = "sada-prj-carbon-analysis"
  schema      = "[{\"description\":\"Month during which this usage occurred.\\n\",\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"description\":\"Billing account ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"description\":\"Project for this usage.\\n\",\"fields\":[{\"description\":\"Project number for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"description\":\"Project ID for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"description\":\"Service for this usage.\\n\",\"fields\":[{\"description\":\"Cloud Billing service ID for the service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"description\":\"Display name for this service.\\n\",\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"description\":\"Location for this usage.\\n\",\"fields\":[{\"description\":\"Cloud location for this usage.\\n\",\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"description\":\"Cloud region for this usage. NULL if usage is multi-regional or global.\\n\",\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"description\":\"Gross carbon footprint (kg CO2e) in the specified location and partition date.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"description\":\"Version of carbon model that produced this output.\\n\",\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id    = "carbon_footprint_export"
}
# terraform import google_bigquery_table.carbon_footprint_export projects/sada-prj-carbon-analysis/datasets/dt_neustar_carbon_export/tables/carbon_footprint_export
resource "google_compute_firewall" "default_allow_ssh" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  description   = "Allow SSH from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-ssh"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  priority      = 65534
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_ssh projects/sada-prj-carbon-analysis/global/firewalls/default-allow-ssh
resource "google_compute_firewall" "default_allow_ssh_steampipe" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "default-allow-ssh-steampipe"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
  priority      = 65534
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_ssh_steampipe projects/sada-prj-carbon-analysis/global/firewalls/default-allow-ssh-steampipe
resource "google_compute_global_address" "default_ip_range" {
  address       = "10.115.0.0"
  address_type  = "INTERNAL"
  name          = "default-ip-range"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  prefix_length = 20
  project       = "sada-prj-carbon-analysis"
  purpose       = "VPC_PEERING"
}
# terraform import google_compute_global_address.default_ip_range projects/sada-prj-carbon-analysis/global/addresses/default-ip-range
resource "google_compute_disk" "pgtest_steampipe_network" {
  image                     = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20220118"
  name                      = "pgtest-steampipe-network"
  physical_block_size_bytes = 4096
  project                   = "sada-prj-carbon-analysis"
  size                      = 10
  type                      = "pd-balanced"
  zone                      = "us-central1-a"
}
# terraform import google_compute_disk.pgtest_steampipe_network projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/pgtest-steampipe-network
resource "google_compute_network" "steampipe_network" {
  auto_create_subnetworks = false
  mtu                     = 1460
  name                    = "steampipe-network"
  project                 = "sada-prj-carbon-analysis"
  routing_mode            = "REGIONAL"
}
# terraform import google_compute_network.steampipe_network projects/sada-prj-carbon-analysis/global/networks/steampipe-network
resource "google_compute_firewall" "default_allow_icmp" {
  allow {
    protocol = "icmp"
  }
  description   = "Allow ICMP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-icmp"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  priority      = 65534
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_icmp projects/sada-prj-carbon-analysis/global/firewalls/default-allow-icmp
resource "google_compute_firewall" "steampipe_network_allow_https" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "steampipe-network-allow-https"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
  priority      = 1000
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}
# terraform import google_compute_firewall.steampipe_network_allow_https projects/sada-prj-carbon-analysis/global/firewalls/steampipe-network-allow-https
resource "google_compute_global_address" "steampipe_network_ip_range" {
  address       = "10.196.128.0"
  address_type  = "INTERNAL"
  name          = "steampipe-network-ip-range"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
  prefix_length = 20
  project       = "sada-prj-carbon-analysis"
  purpose       = "VPC_PEERING"
}
# terraform import google_compute_global_address.steampipe_network_ip_range projects/sada-prj-carbon-analysis/global/addresses/steampipe-network-ip-range
resource "google_compute_instance" "steampipe_svc_7bf274f23697a0a8" {
  boot_disk {
    auto_delete = true
    device_name = "persistent-disk-0"
    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/sada-prj-carbon-analysis/global/images/steampipe-service-v1"
      size  = 20
      type  = "pd-standard"
    }
    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/steampipe-svc-7bf274f23697a0a8"
  }
  machine_type = "e2-standard-2"
  metadata = {
    startup-script = "su - steampipe -c 'steampipe service start'"
  }
  name = "steampipe-svc-7bf274f23697a0a8"
  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
    network_ip         = "10.2.0.2"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/regions/us-central1/subnetworks/steampipe-subnet-us-central1"
    subnetwork_project = "sada-prj-carbon-analysis"
  }
  project = "sada-prj-carbon-analysis"
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    email  = "sa-steampipe-access@sada-prj-carbon-analysis.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }
  zone = "us-central1-a"
}
# terraform import google_compute_instance.steampipe_svc_7bf274f23697a0a8 projects/sada-prj-carbon-analysis/zones/us-central1-a/instances/steampipe-svc-7bf274f23697a0a8
resource "google_compute_instance" "suk_db_client_test" {
  boot_disk {
    auto_delete = true
    device_name = "suk-db-client-test"
    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20220118"
      size  = 10
      type  = "pd-balanced"
    }
    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/suk-db-client-test"
  }
  confidential_instance_config {
    enable_confidential_compute = false
  }
  machine_type = "e2-micro"
  name         = "suk-db-client-test"
  network_interface {
    access_config {
      nat_ip       = "35.224.240.140"
      network_tier = "PREMIUM"
    }
    network            = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
    network_ip         = "10.128.0.3"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/regions/us-central1/subnetworks/default"
    subnetwork_project = "sada-prj-carbon-analysis"
  }
  project = "sada-prj-carbon-analysis"
  reservation_affinity {
    type = "ANY_RESERVATION"
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    email  = "1060261191865-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }
  zone = "us-central1-a"
}
# terraform import google_compute_instance.suk_db_client_test projects/sada-prj-carbon-analysis/zones/us-central1-a/instances/suk-db-client-test
resource "google_compute_firewall" "default_allow_https" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "default-allow-https"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  priority      = 1000
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}
# terraform import google_compute_firewall.default_allow_https projects/sada-prj-carbon-analysis/global/firewalls/default-allow-https
resource "google_bigquery_table" "digital_turbine_invoice" {
  dataset_id = "projects_invoice"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"mode\":\"NULLABLE\",\"name\":\"Usage_Month\",\"type\":\"DATE\"},{\"mode\":\"NULLABLE\",\"name\":\"Project\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"Project_ID\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"Project_number\",\"type\":\"INTEGER\"},{\"mode\":\"NULLABLE\",\"name\":\"List_cost\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"Negotiated_savings\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"Discounts\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"Promotions_and_others\",\"type\":\"INTEGER\"},{\"mode\":\"NULLABLE\",\"name\":\"Subtotal\",\"type\":\"FLOAT\"}]"
  table_id   = "digital_turbine_invoice"
}
# terraform import google_bigquery_table.digital_turbine_invoice projects/sada-prj-carbon-analysis/datasets/projects_invoice/tables/digital_turbine_invoice
resource "google_compute_firewall" "default_allow_internal" {
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  description   = "Allow internal traffic on the default network"
  direction     = "INGRESS"
  name          = "default-allow-internal"
  network       = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  priority      = 65534
  project       = "sada-prj-carbon-analysis"
  source_ranges = ["10.128.0.0/9"]
}
# terraform import google_compute_firewall.default_allow_internal projects/sada-prj-carbon-analysis/global/firewalls/default-allow-internal
resource "google_compute_instance" "pgtest_steampipe_network" {
  boot_disk {
    auto_delete = true
    device_name = "pgtest-steampipe-network"
    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20220118"
      size  = 10
      type  = "pd-balanced"
    }
    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/pgtest-steampipe-network"
  }
  confidential_instance_config {
    enable_confidential_compute = false
  }
  machine_type = "e2-medium"
  name         = "pgtest-steampipe-network"
  network_interface {
    access_config {
      nat_ip       = "35.209.21.4"
      network_tier = "STANDARD"
    }
    network            = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
    network_ip         = "10.2.0.4"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/regions/us-central1/subnetworks/steampipe-subnet-us-central1"
    subnetwork_project = "sada-prj-carbon-analysis"
  }
  project = "sada-prj-carbon-analysis"
  reservation_affinity {
    type = "ANY_RESERVATION"
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    email  = "1060261191865-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }
  tags = ["https-server"]
  zone = "us-central1-a"
}
# terraform import google_compute_instance.pgtest_steampipe_network projects/sada-prj-carbon-analysis/zones/us-central1-a/instances/pgtest-steampipe-network
resource "google_bigquery_table" "neustar_december" {
  dataset_id = "dt_neustar_carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"mode\":\"NULLABLE\",\"name\":\"usage_month\",\"type\":\"DATE\"},{\"mode\":\"NULLABLE\",\"name\":\"billing_account_id\",\"type\":\"STRING\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"number\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"project\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"description\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"service\",\"type\":\"RECORD\"},{\"fields\":[{\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"}],\"mode\":\"NULLABLE\",\"name\":\"location\",\"type\":\"RECORD\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_footprint_kgCO2e\",\"type\":\"FLOAT\"},{\"mode\":\"NULLABLE\",\"name\":\"carbon_model_version\",\"type\":\"INTEGER\"}]"
  table_id   = "neustar_december"
}
# terraform import google_bigquery_table.neustar_december projects/sada-prj-carbon-analysis/datasets/dt_neustar_carbon_export/tables/neustar_december
resource "google_compute_instance" "pgtest" {
  boot_disk {
    auto_delete = true
    device_name = "pgtest"
    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20220118"
      size  = 10
      type  = "pd-balanced"
    }
    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/pgtest"
  }
  confidential_instance_config {
    enable_confidential_compute = false
  }
  machine_type = "e2-medium"
  name         = "pgtest"
  network_interface {
    access_config {
      nat_ip       = "130.211.233.231"
      network_tier = "PREMIUM"
    }
    network            = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
    network_ip         = "10.128.0.4"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/regions/us-central1/subnetworks/default"
    subnetwork_project = "sada-prj-carbon-analysis"
  }
  project = "sada-prj-carbon-analysis"
  reservation_affinity {
    type = "ANY_RESERVATION"
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    email  = "1060261191865-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }
  zone = "us-central1-a"
}
# terraform import google_compute_instance.pgtest projects/sada-prj-carbon-analysis/zones/us-central1-a/instances/pgtest
resource "google_compute_disk" "steampipe_test" {
  image                     = "https://www.googleapis.com/compute/beta/projects/sada-prj-carbon-analysis/global/images/steampipe-service-v1"
  name                      = "steampipe-test"
  physical_block_size_bytes = 4096
  project                   = "sada-prj-carbon-analysis"
  size                      = 20
  type                      = "pd-balanced"
  zone                      = "us-central1-a"
}
# terraform import google_compute_disk.steampipe_test projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/steampipe-test
resource "google_bigquery_table" "total_cost_by_month" {
  dataset_id = "carbon_export"
  project    = "sada-prj-carbon-analysis"
  schema     = "[{\"name\":\"id\",\"type\":\"STRING\"},{\"name\":\"month\",\"type\":\"STRING\"},{\"name\":\"total_cost\",\"type\":\"FLOAT\"}]"
  table_id   = "total_cost_by_month"
  view {
    query          = "SELECT project.id, invoice.month, ROUND(sum(cost),2) as total_cost\nFROM `corp-skyrise.gcpBillingExports.gcpBillingUnion`\nwhere project.id = 'sada-gke-on-prem-demo'\ngroup by 1, 2\norder by month desc"
    use_legacy_sql = false
  }
}
# terraform import google_bigquery_table.total_cost_by_month projects/sada-prj-carbon-analysis/datasets/carbon_export/tables/total_cost_by_month
resource "google_compute_instance" "steampipe_test" {
  boot_disk {
    auto_delete = true
    device_name = "steampipe-test"
    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/sada-prj-carbon-analysis/global/images/steampipe-service-v1"
      size  = 20
      type  = "pd-balanced"
    }
    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/steampipe-test"
  }
  confidential_instance_config {
    enable_confidential_compute = false
  }
  machine_type = "e2-medium"
  metadata = {
    startup-script = "su - steampipe -c 'steampipe service start'"
  }
  name = "steampipe-test"
  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
    network_ip         = "10.128.0.49"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/regions/us-central1/subnetworks/default"
    subnetwork_project = "sada-prj-carbon-analysis"
  }
  project = "sada-prj-carbon-analysis"
  reservation_affinity {
    type = "ANY_RESERVATION"
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    email  = "sa-steampipe-access@sada-prj-carbon-analysis.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }
  zone = "us-central1-a"
}
# terraform import google_compute_instance.steampipe_test projects/sada-prj-carbon-analysis/zones/us-central1-a/instances/steampipe-test
resource "google_compute_instance" "suk_worker_dev" {
  boot_disk {
    auto_delete = true
    device_name = "suk-worker-dev"
    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/debian-cloud/global/images/debian-10-buster-v20211209"
      size  = 10
      type  = "pd-balanced"
    }
    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/suk-worker-dev"
  }
  confidential_instance_config {
    enable_confidential_compute = false
  }
  machine_type = "e2-medium"
  name         = "suk-worker-dev"
  network_interface {
    access_config {
      nat_ip       = "34.135.93.149"
      network_tier = "PREMIUM"
    }
    network            = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
    network_ip         = "10.128.0.2"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/regions/us-central1/subnetworks/default"
    subnetwork_project = "sada-prj-carbon-analysis"
  }
  project = "sada-prj-carbon-analysis"
  reservation_affinity {
    type = "ANY_RESERVATION"
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    email  = "1060261191865-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }
  tags = ["steampipe-ingress"]
  zone = "us-central1-a"
}
# terraform import google_compute_instance.suk_worker_dev projects/sada-prj-carbon-analysis/zones/us-central1-a/instances/suk-worker-dev
resource "google_compute_route" "peering_route_0eed7dc22a822b35" {
  description = "Auto generated route via peering [servicenetworking-googleapis-com]."
  dest_range  = "10.196.128.0/24"
  name        = "peering-route-0eed7dc22a822b35"
  network     = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
  priority    = 0
  project     = "sada-prj-carbon-analysis"
}
# terraform import google_compute_route.peering_route_0eed7dc22a822b35 projects/sada-prj-carbon-analysis/global/routes/peering-route-0eed7dc22a822b35
resource "google_service_account" "sa_steampipe_access" {
  account_id   = "sa-steampipe-access"
  display_name = "sa - Steampipe Viewer Service"
  project      = "sada-prj-carbon-analysis"
}
# terraform import google_service_account.sa_steampipe_access projects/sada-prj-carbon-analysis/serviceAccounts/sa-steampipe-access@sada-prj-carbon-analysis.iam.gserviceaccount.com
resource "google_project_service" "bigqueryconnection_googleapis_com" {
  project = "1060261191865"
  service = "bigqueryconnection.googleapis.com"
}
# terraform import google_project_service.bigqueryconnection_googleapis_com 1060261191865/bigqueryconnection.googleapis.com
resource "google_project_service" "cloudasset_googleapis_com" {
  project = "1060261191865"
  service = "cloudasset.googleapis.com"
}
# terraform import google_project_service.cloudasset_googleapis_com 1060261191865/cloudasset.googleapis.com
resource "google_project_service" "bigquery_googleapis_com" {
  project = "1060261191865"
  service = "bigquery.googleapis.com"
}
# terraform import google_project_service.bigquery_googleapis_com 1060261191865/bigquery.googleapis.com
resource "google_service_account" "sada_prj_carbon_analysis" {
  account_id   = "sada-prj-carbon-analysis"
  display_name = "App Engine default service account"
  project      = "sada-prj-carbon-analysis"
}
# terraform import google_service_account.sada_prj_carbon_analysis projects/sada-prj-carbon-analysis/serviceAccounts/sada-prj-carbon-analysis@sada-prj-carbon-analysis.iam.gserviceaccount.com
resource "google_compute_subnetwork" "steampipe_subnet_us_central1" {
  ip_cidr_range              = "10.2.0.0/16"
  name                       = "steampipe-subnet-us-central1"
  network                    = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/steampipe-network"
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = "sada-prj-carbon-analysis"
  purpose                    = "PRIVATE"
  region                     = "us-central1"
  stack_type                 = "IPV4_ONLY"
}
# terraform import google_compute_subnetwork.steampipe_subnet_us_central1 projects/sada-prj-carbon-analysis/regions/us-central1/subnetworks/steampipe-subnet-us-central1
resource "google_project_service" "artifactregistry_googleapis_com" {
  project = "1060261191865"
  service = "artifactregistry.googleapis.com"
}
# terraform import google_project_service.artifactregistry_googleapis_com 1060261191865/artifactregistry.googleapis.com
resource "google_project_service" "bigquerystorage_googleapis_com" {
  project = "1060261191865"
  service = "bigquerystorage.googleapis.com"
}
# terraform import google_project_service.bigquerystorage_googleapis_com 1060261191865/bigquerystorage.googleapis.com
resource "google_service_account" "sa_carbon_offset" {
  account_id   = "sa-carbon-offset"
  display_name = "Carbon Offset"
  project      = "sada-prj-carbon-analysis"
}
# terraform import google_service_account.sa_carbon_offset projects/sada-prj-carbon-analysis/serviceAccounts/sa-carbon-offset@sada-prj-carbon-analysis.iam.gserviceaccount.com
resource "google_project_service" "dataflow_googleapis_com" {
  project = "1060261191865"
  service = "dataflow.googleapis.com"
}
# terraform import google_project_service.dataflow_googleapis_com 1060261191865/dataflow.googleapis.com
resource "google_project_service" "storage_component_googleapis_com" {
  project = "1060261191865"
  service = "storage-component.googleapis.com"
}
# terraform import google_project_service.storage_component_googleapis_com 1060261191865/storage-component.googleapis.com
resource "google_logging_log_sink" "a_default" {
  destination            = "logging.googleapis.com/projects/sada-prj-carbon-analysis/locations/global/buckets/_Default"
  filter                 = "NOT LOG_ID(\"cloudaudit.googleapis.com/activity\") AND NOT LOG_ID(\"externalaudit.googleapis.com/activity\") AND NOT LOG_ID(\"cloudaudit.googleapis.com/system_event\") AND NOT LOG_ID(\"externalaudit.googleapis.com/system_event\") AND NOT LOG_ID(\"cloudaudit.googleapis.com/access_transparency\") AND NOT LOG_ID(\"externalaudit.googleapis.com/access_transparency\")"
  name                   = "_Default"
  project                = "1060261191865"
  unique_writer_identity = true
}
# terraform import google_logging_log_sink.a_default 1060261191865###_Default
resource "google_logging_log_sink" "a_required" {
  destination            = "logging.googleapis.com/projects/sada-prj-carbon-analysis/locations/global/buckets/_Required"
  filter                 = "LOG_ID(\"cloudaudit.googleapis.com/activity\") OR LOG_ID(\"externalaudit.googleapis.com/activity\") OR LOG_ID(\"cloudaudit.googleapis.com/system_event\") OR LOG_ID(\"externalaudit.googleapis.com/system_event\") OR LOG_ID(\"cloudaudit.googleapis.com/access_transparency\") OR LOG_ID(\"externalaudit.googleapis.com/access_transparency\")"
  name                   = "_Required"
  project                = "1060261191865"
  unique_writer_identity = true
}
# terraform import google_logging_log_sink.a_required 1060261191865###_Required
resource "google_compute_image" "steampipe_service_v1" {
  description  = "Steampipe service machine."
  disk_size_gb = 20
  guest_os_features {
    type = "UEFI_COMPATIBLE"
  }
  guest_os_features {
    type = "VIRTIO_SCSI_MULTIQUEUE"
  }
  labels = {
    developer = "supercoolsteampipedev"
    team      = "carbon"
  }
  licenses    = ["https://www.googleapis.com/compute/v1/projects/debian-cloud/global/licenses/debian-10-buster"]
  name        = "steampipe-service-v1"
  project     = "sada-prj-carbon-analysis"
  source_disk = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/zones/us-central1-a/disks/packer-621d9809-2969-de63-bf74-3f330fad1a3c"
}
# terraform import google_compute_image.steampipe_service_v1 projects/sada-prj-carbon-analysis/global/images/steampipe-service-v1
resource "google_project_service" "cloudscheduler_googleapis_com" {
  project = "1060261191865"
  service = "cloudscheduler.googleapis.com"
}
# terraform import google_project_service.cloudscheduler_googleapis_com 1060261191865/cloudscheduler.googleapis.com
resource "google_project_service" "logging_googleapis_com" {
  project = "1060261191865"
  service = "logging.googleapis.com"
}
# terraform import google_project_service.logging_googleapis_com 1060261191865/logging.googleapis.com
resource "google_project_service" "containerregistry_googleapis_com" {
  project = "1060261191865"
  service = "containerregistry.googleapis.com"
}
# terraform import google_project_service.containerregistry_googleapis_com 1060261191865/containerregistry.googleapis.com
resource "google_compute_route" "peering_route_841da5c8e959b397" {
  description = "Auto generated route via peering [servicenetworking-googleapis-com]."
  dest_range  = "10.115.0.0/24"
  name        = "peering-route-841da5c8e959b397"
  network     = "https://www.googleapis.com/compute/v1/projects/sada-prj-carbon-analysis/global/networks/default"
  priority    = 0
  project     = "sada-prj-carbon-analysis"
}
# terraform import google_compute_route.peering_route_841da5c8e959b397 projects/sada-prj-carbon-analysis/global/routes/peering-route-841da5c8e959b397
resource "google_project_service" "storage_googleapis_com" {
  project = "1060261191865"
  service = "storage.googleapis.com"
}
# terraform import google_project_service.storage_googleapis_com 1060261191865/storage.googleapis.com
resource "google_iam_custom_role" "steampipeviewer" {
  description = "Custom role for viewing resources for access from the Steampipe service."
  permissions = ["logging.buckets.list", "logging.exclusions.list", "logging.logMetrics.list", "logging.sinks.list"]
  project     = "sada-prj-carbon-analysis"
  role_id     = "steampipeViewer"
  stage       = "GA"
  title       = "Steampipe Resoource Viewer"
}
# terraform import google_iam_custom_role.steampipeviewer sada-prj-carbon-analysis##steampipeViewer
resource "google_project_service" "run_googleapis_com" {
  project = "1060261191865"
  service = "run.googleapis.com"
}
# terraform import google_project_service.run_googleapis_com 1060261191865/run.googleapis.com
resource "google_project_service" "compute_googleapis_com" {
  project = "1060261191865"
  service = "compute.googleapis.com"
}
# terraform import google_project_service.compute_googleapis_com 1060261191865/compute.googleapis.com
resource "google_project_service" "deploymentmanager_googleapis_com" {
  project = "1060261191865"
  service = "deploymentmanager.googleapis.com"
}
# terraform import google_project_service.deploymentmanager_googleapis_com 1060261191865/deploymentmanager.googleapis.com
resource "google_project_service" "cloudresourcemanager_googleapis_com" {
  project = "1060261191865"
  service = "cloudresourcemanager.googleapis.com"
}
# terraform import google_project_service.cloudresourcemanager_googleapis_com 1060261191865/cloudresourcemanager.googleapis.com
resource "google_project_service" "sqladmin_googleapis_com" {
  project = "1060261191865"
  service = "sqladmin.googleapis.com"
}
# terraform import google_project_service.sqladmin_googleapis_com 1060261191865/sqladmin.googleapis.com
resource "google_project_service" "websecurityscanner_googleapis_com" {
  project = "1060261191865"
  service = "websecurityscanner.googleapis.com"
}
# terraform import google_project_service.websecurityscanner_googleapis_com 1060261191865/websecurityscanner.googleapis.com
resource "google_project_service" "clouddebugger_googleapis_com" {
  project = "1060261191865"
  service = "clouddebugger.googleapis.com"
}
# terraform import google_project_service.clouddebugger_googleapis_com 1060261191865/clouddebugger.googleapis.com
resource "google_storage_bucket" "sada_carbon_analysis_tf_state_bucket" {
  force_destroy               = false
  location                    = "US-CENTRAL1"
  name                        = "sada-carbon-analysis-tf-state-bucket"
  project                     = "sada-prj-carbon-analysis"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
# terraform import google_storage_bucket.sada_carbon_analysis_tf_state_bucket sada-carbon-analysis-tf-state-bucket
resource "google_project_service" "serviceusage_googleapis_com" {
  project = "1060261191865"
  service = "serviceusage.googleapis.com"
}
# terraform import google_project_service.serviceusage_googleapis_com 1060261191865/serviceusage.googleapis.com
resource "google_project_service" "servicenetworking_googleapis_com" {
  project = "1060261191865"
  service = "servicenetworking.googleapis.com"
}
# terraform import google_project_service.servicenetworking_googleapis_com 1060261191865/servicenetworking.googleapis.com
resource "google_project_service" "oslogin_googleapis_com" {
  project = "1060261191865"
  service = "oslogin.googleapis.com"
}
# terraform import google_project_service.oslogin_googleapis_com 1060261191865/oslogin.googleapis.com
resource "google_storage_bucket" "dataprep_staging_9f1dd747_ef17_4ea9_bf20_5d1767ab1aee" {
  force_destroy            = false
  location                 = "US"
  name                     = "dataprep-staging-9f1dd747-ef17-4ea9-bf20-5d1767ab1aee"
  project                  = "sada-prj-carbon-analysis"
  public_access_prevention = "inherited"
  storage_class            = "MULTI_REGIONAL"
}
# terraform import google_storage_bucket.dataprep_staging_9f1dd747_ef17_4ea9_bf20_5d1767ab1aee dataprep-staging-9f1dd747-ef17-4ea9-bf20-5d1767ab1aee
resource "google_project_service" "monitoring_googleapis_com" {
  project = "1060261191865"
  service = "monitoring.googleapis.com"
}
# terraform import google_project_service.monitoring_googleapis_com 1060261191865/monitoring.googleapis.com
resource "google_project_service" "cloudtrace_googleapis_com" {
  project = "1060261191865"
  service = "cloudtrace.googleapis.com"
}
# terraform import google_project_service.cloudtrace_googleapis_com 1060261191865/cloudtrace.googleapis.com
resource "google_storage_bucket" "us_artifacts_sada_prj_carbon_analysis_appspot_com" {
  force_destroy            = false
  location                 = "US"
  name                     = "us.artifacts.sada-prj-carbon-analysis.appspot.com"
  project                  = "sada-prj-carbon-analysis"
  public_access_prevention = "inherited"
  storage_class            = "STANDARD"
}
# terraform import google_storage_bucket.us_artifacts_sada_prj_carbon_analysis_appspot_com us.artifacts.sada-prj-carbon-analysis.appspot.com
resource "google_service_account" "1060261191865_compute" {
  account_id   = "1060261191865-compute"
  display_name = "Compute Engine default service account"
  project      = "sada-prj-carbon-analysis"
}
# terraform import google_service_account.1060261191865_compute projects/sada-prj-carbon-analysis/serviceAccounts/1060261191865-compute@sada-prj-carbon-analysis.iam.gserviceaccount.com
resource "google_project_service" "pubsub_googleapis_com" {
  project = "1060261191865"
  service = "pubsub.googleapis.com"
}
# terraform import google_project_service.pubsub_googleapis_com 1060261191865/pubsub.googleapis.com
resource "google_project_service" "bigquerydatatransfer_googleapis_com" {
  project = "1060261191865"
  service = "bigquerydatatransfer.googleapis.com"
}
# terraform import google_project_service.bigquerydatatransfer_googleapis_com 1060261191865/bigquerydatatransfer.googleapis.com
resource "google_storage_bucket" "suk_bucket_script" {
  force_destroy               = false
  location                    = "US"
  name                        = "suk-bucket-script"
  project                     = "sada-prj-carbon-analysis"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
# terraform import google_storage_bucket.suk_bucket_script suk-bucket-script
resource "google_project_service" "servicemanagement_googleapis_com" {
  project = "1060261191865"
  service = "servicemanagement.googleapis.com"
}
# terraform import google_project_service.servicemanagement_googleapis_com 1060261191865/servicemanagement.googleapis.com
resource "google_project_service" "cloudfunctions_googleapis_com" {
  project = "1060261191865"
  service = "cloudfunctions.googleapis.com"
}
# terraform import google_project_service.cloudfunctions_googleapis_com 1060261191865/cloudfunctions.googleapis.com
resource "google_project_service" "datastore_googleapis_com" {
  project = "1060261191865"
  service = "datastore.googleapis.com"
}
# terraform import google_project_service.datastore_googleapis_com 1060261191865/datastore.googleapis.com
resource "google_project_service" "cloudbuild_googleapis_com" {
  project = "1060261191865"
  service = "cloudbuild.googleapis.com"
}
# terraform import google_project_service.cloudbuild_googleapis_com 1060261191865/cloudbuild.googleapis.com
resource "google_project_service" "sql_component_googleapis_com" {
  project = "1060261191865"
  service = "sql-component.googleapis.com"
}
# terraform import google_project_service.sql_component_googleapis_com 1060261191865/sql-component.googleapis.com
resource "google_project_service" "storage_api_googleapis_com" {
  project = "1060261191865"
  service = "storage-api.googleapis.com"
}
# terraform import google_project_service.storage_api_googleapis_com 1060261191865/storage-api.googleapis.com
