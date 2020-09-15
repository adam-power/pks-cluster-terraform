#!/bin/bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0} <cluster name>"
  exit 1
fi

export TF_VAR_cluster_name="$1"

master_ips=$(pks cluster --json "$1" \
  | jq -r '.kubernetes_master_ips[]')

TF_VAR_master_nics=""
for ip in $master_ips ; do
  if [ "$TF_VAR_master_nics" != ""  ]; then
    TF_VAR_master_nics="${TF_VAR_master_nics},"
  fi

  # Shellcheck warns against having literal quotes inside the variable
  # We need the quotes to be there so Terraform reads this as an array
  # shellcheck disable=SC2089
  TF_VAR_master_nics="${TF_VAR_master_nics}\"$(az network nic list \
    --query "[?ipConfigurations[?privateIpAddress=='${ip}']].name" \
    --output yaml \
    | awk '/- / {print $2}')\""
done
TF_VAR_master_nics="[${TF_VAR_master_nics}]"

# Shellcheck warns against having literal quotes inside the variable
# We need the quotes to be there so Terraform reads this as an array
# shellcheck disable=SC2090
export TF_VAR_master_nics

terraform init
terraform apply --auto-approve
