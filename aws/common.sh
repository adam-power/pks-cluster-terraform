#!/bin/sh

exportTFVars() {
  TF_VAR_cluster_name="$1"
  TF_VAR_cluster_external_dns=$(pks cluster --json "$1" \
    | jq -r '.parameters.kubernetes_master_host')
  TF_VAR_cluster_uuid=$(pks cluster --json "$1" \
    | jq -r '.uuid')

  export TF_VAR_cluster_name
  export TF_VAR_cluster_external_dns
  export TF_VAR_cluster_uuid
}

exportAWSVars() {

  # shellcheck disable=SC2154
  aws_access_key_id=$(awk -F '=' '/access_key/ {print $2}' "${script_dir}/terraform.tfvars")
  aws_secret_access_key=$(awk -F '=' '/secret_key/ {print $2}' "${script_dir}/terraform.tfvars")
  aws_default_region=$(awk -F '=' '/region/ {print $2}' "${script_dir}/terraform.tfvars")

  AWS_ACCESS_KEY_ID=$(echo "$aws_access_key_id" | tr -d '" ')
  AWS_SECRET_ACCESS_KEY=$(echo "$aws_secret_access_key" | tr -d '" ')
  AWS_DEFAULT_REGION=$(echo "$aws_default_region" | tr -d '" ')

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  export AWS_DEFAULT_REGION
}
