# PKS Cluster Terraform

These Terraform configs create the necessary infrastructure around a PKS Kubernetes cluster.
This includes:

+ An Elastic Load Balancer for the k8s master(s)
+ A Route53 DNS record to match the PKS cluster's external hostname

Currently AWS only.

## Usage

1. Create a `terraform.tfvars` file and fill it in with the following values:

```
# PKS vars
cluster_name          = "pks-cluster-name"
cluster_external_dns  = "pks-external-hostname"
cluster_uuid          = "pks-cluster-uuid"

# AWS vars
access_key            = "access key"
secret_key            = "secret key"
region                = "eu-west-2"
subnet_ids            = ["subnet1", "subnet2", "subnet3"]
master_security_group = "master SG"
zone_id               = "zone ID"
```

**NOTE:** If you paved your infrastructure using [terraforming-aws](https://github.com/pivotal-cf/terraforming-aws), you can reference the following Terraform outputs:
+ `subnet_ids` = `public_subnet_ids`
+ `zone_id` = `dns_zone_id`
+ `master_security_group` = `pks_master_security_group_id`

1. Initialize Terraform and apply

```bash
terraform init
terraform apply
```

## Wrapper script

If you are logged in with the PKS CLI, you can remove the `cluster_name`, `cluster_external_dns` and `cluster_uuid` variables from your TF vars file and run the create script instead:

```bash
./create.sh <your cluster name>
```
