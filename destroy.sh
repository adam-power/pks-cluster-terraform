#!/bin/sh

set -eu

script_dir="$(cd "$(dirname "$0")"; pwd -P)"

# Ignore shellcheck warning, common.sh will be
# checked separately
#
# shellcheck source=/dev/null
. "${script_dir}/common.sh"

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0} <cluster name>"
  exit 1
fi

cluster_name="$1"

exportTFVars "$cluster_name"

terraform destroy --auto-approve
