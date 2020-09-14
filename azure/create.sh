#!/bin/bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0} <cluster name>"
  exit 1
fi

TF_VAR_cluster_name="$1"
export TF_VAR_cluster_name

terraform init
terraform apply --auto-approve
