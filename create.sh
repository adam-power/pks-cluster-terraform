#!/bin/sh

set -euo pipefail

script_dir="$(cd "$(dirname "$0")"; pwd -P)"

# shellcheck source=common.sh
. "${script_dir}/common.sh"

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0} <cluster name>"
  exit 1
fi

cluster_name="$1"

exportTFVars "$cluster_name"

subnet_ids="$(awk -F '=' '/subnet_ids/ {print $2}' "${script_dir}/terraform.tfvars" \
  | tr -d '[]",')"

terraform init
terraform apply --auto-approve

exportAWSVars

# shellcheck disable=SC2086
aws ec2 create-tags \
  --resources $subnet_ids \
  --tags "Key=\"kubernetes.io/cluster/service-instance_${TF_VAR_cluster_uuid}\",Value=\"\"" \
