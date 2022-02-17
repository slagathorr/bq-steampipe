#! /bin/bash
echo "---\nINFO: starting steampipe install\n---"
echo "---\nINFO: user add\n---"
useradd -m steampipe
echo "---\nINFO: download and install steampipe\n---"
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/turbot/steampipe/main/install.sh)"
echo "---\nINFO: run the post install commands\n---"
su -u steampipe steampipe steampipe plugin install gcp ; steampipe steampipe service start