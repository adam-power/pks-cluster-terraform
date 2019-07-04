#!/bin/sh

set -eu

script_dir="$(cd "$(dirname "$0")"; pwd -P)"

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0} <cluster name>"
  exit 1
fi

cluster_name="$1"

export TF_VAR_cluster_name="$cluster_name"
export TF_VAR_cluster_external_dns="$(pks cluster --json "$cluster_name" \
  | jq -r '.parameters.kubernetes_master_host')"

terraform init

terraform apply --auto-approve
