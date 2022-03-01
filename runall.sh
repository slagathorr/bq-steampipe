echo "\n---\nINFO: Creating Packer image for GCE.\n---"
cd packer
# This assumes your variables file is variables.pkvars.hcl so change if not true.
packer build -var-file=variables.pkrvars.hcl steampipe.pkr.hcl
cd ..
echo "done"

echo "\n---\nINFO: Create if not exists main infrastructure.\n---"
cd terraform
terraform init
terraform apply --auto-approve
echo "done"