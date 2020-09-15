# PKS Cluster Terraform for Azure

These Terraform configs create the necessary infrastructure around a PKS Kubernetes cluster.
This includes:

+ An Azure Load Balancer for the k8s master(s)
+ An Azure DNS record to match the PKS cluster's external hostname
+ (optional) If necessary, you can also add an application security group to your k8s master(s)

## Usage

1. Create a `terraform.tfvars` file and fill it in with the following values:

```
# PKS vars
cluster_name = "pks-cluster-name"
master_nics  = ["k8s-master-nic1", "k8s-master-nic2", "k8s-master-nic3"]

# Azure vars
subscription_id              = "subscription-id"
tenant_id                    = "tenant-id"
client_id                    = "client-id"
client_secret                = "client-secret"
location                     = "location"
resource_group_name          = "resource-group-name"
dns_zone_name                = "example.com"
dns_zone_resource_group_name = "dns-resource-group-name"

# Optional vars
# cloud_name = "public"
# master_asg = "master-asg"
```

1. Initialize Terraform and apply

```bash
terraform init
terraform apply
```

## Wrapper script

If you are logged in with the PKS CLI, you can remove the `cluster_name` and `master_nics` variables from your TF vars file and run the create script instead:

```bash
./create.sh <your cluster name>
```

You can clean up by running the destroy script:

```bash
./destroy.sh <your cluster name>
```
