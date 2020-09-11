#!/bin/bash

exportTFVars() {
  TF_VAR_cluster_name="$1"
  TF_VAR_cluster_external_dns=$(pks cluster --json "$1" \
    | jq -r '.parameters.kubernetes_master_host')

  export TF_VAR_cluster_name
  export TF_VAR_cluster_external_dns
}
