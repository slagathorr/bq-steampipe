echo "\n---\nINFO: Setting variables.\n---"
# The tag for the Steampipe Docker image. Also change this in your tfvars file if it's different.
steampipe_image_version="0.12.2" # This was used when pulling Docker images.
# This assumes the default of us-central1. Change appropriately.
gcp_region="us-central1"
# This also assumes you have run gcloud init and set it to your main project.
gcp_project="$(gcloud config get-value project)"
echo "done"

# All the below is commented out in case we add Cloud Run later.
#echo "\n---\nINFO: Getting the Steampipe image.\n---"
#docker pull turbot/steampipe:${steampipe_image_version}

#echo "\n---\nINFO: Create if not exists the Artifact Registry for Docker.\n---"
#cd terraform/registry
#terraform init
#terraform apply --auto-approve


#echo "\n---\nINFO: Tagging the image to Artifact Registry\n---"
#docker tag turbot/steampipe ${gcp_region}-docker.pkg.dev/${gcp_project}/steampipe-repo/steampipe:${steampipe_image_version}
#echo "done"

#echo "\n---\nINFO: Push it.\n---"
#gcloud auth configure-docker ${gcp_region}-docker.pkg.dev
#docker push ${gcp_region}-docker.pkg.dev/${gcp_project}/steampipe-repo/steampipe:${steampipe_image_version}
#echo "\n---\nINFO: Push it real good *cue salt-n-pepa dance*.\n---"
# /end run stuff

echo "\n---\nINFO: Creating Packer image for GCE.\n---"
cd packer
packer build -var-file=variables.pkrvars.hcl steampipe.pkr.hcl
cd ..
echo "done"

echo "\n---\nINFO: Create if not exists main infrastructure.\n---"
cd terraform
terraform init
terraform apply --auto-approve