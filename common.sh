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
