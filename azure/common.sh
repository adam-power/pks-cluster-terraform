#!/bin/bash

exportTFVars() {
  TF_VAR_cluster_name="$1"

  export TF_VAR_cluster_name
}
