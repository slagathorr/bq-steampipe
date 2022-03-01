#! /bin/bash
echo "---\nINFO: starting steampipe install\n---"
echo "---\nINFO: download and install steampipe\n---"
sudo /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/turbot/steampipe/main/install.sh)"
echo "---\nINFO: run the post install commands\n---"
steampipe plugin install gcp