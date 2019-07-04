# PKS Cluster Terraform

These Terraform configs create the necessary infrastructure around a PKS Kubernetes cluster.
This includes:

+ An Elastic Load Balancer for k8s masters
+ A Route53 DNS record to match the PKS cluster's external hostname

Currently AWS only.

## Usage

1. Create a `terraform.tfvars` file and fill it in with the following values:

```
cluster_name          = "pks-cluster-name"
access_key            = "access key"
secret_key            = "secret key"
region                = "eu-west-2"
subnet_ids            = ["subnet1", "subnet2", "subnet3"]
master_security_group = "master SG"
master_ids            = ["master1", "master2", "master3"]
zone_id               = "zone ID"
```

**NOTE:** If you paved your infrastructure using (terraforming-aws)[https://github.com/pivotal-cf/terraforming-aws], you can reference the following Terraform outputs:
+ `subnet_ids` = `services_subnet_ids`
+ `zone_id` = `dns_zone_id`

1. Initialize Terraform and apply

```bash
terraform init
terraform apply
```
