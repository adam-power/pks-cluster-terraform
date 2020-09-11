#!/bin/bash

set -euo pipefail

script_dir="$(cd "$(dirname "$0")"; pwd -P)"

# Shellcheck can't follow this file for some reason
# shellcheck disable=SC1090
. "${script_dir}/common.sh"

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0} <cluster name>"
  exit 1
fi

cluster_name="$1"

exportTFVars "$cluster_name"

terraform destroy --auto-approve
