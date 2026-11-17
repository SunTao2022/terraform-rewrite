# Azure Network and Linux VM with Terraform

A personal Infrastructure as Code lab using reusable Terraform modules for Azure networking and Linux compute.

> **Review the Terraform plan and Azure costs before applying.** This is lab code, not a production-ready Azure landing zone.

## What it creates

- Azure resource group and virtual network.
- Subnet with a Network Security Group (NSG).
- Linux virtual machine with SSH public-key authentication.
- Public IP and network interface.
- Terraform state in a pre-existing Azure Storage account/container.

```text
Resource Group
└── Virtual Network
    └── Subnet (10.0.1.0/24 in the current module)
        ├── NSG: SSH permitted only from ssh_source_cidr
        └── Linux VM NIC + Standard Public IP

Terraform state -> existing Azure Storage backend
```

## Structure

- `main.tf`: root configuration referencing networking and compute modules.
- `modules/networking/`: VNet, subnet and NSG.
- `modules/compute/`: network interface, public IP and Ubuntu Linux VM.
- `provider.tf`: Azure provider and state backend.

## Configure

Install Terraform and Azure CLI, log into your Azure subscription, and ensure the state Storage account/container already exist. The backend settings in `provider.tf` are lab-specific; replace/override them to use your own resources.

Copy the included example file and set your own values:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and replace all example placeholders.
az login
terraform fmt -recursive
terraform init
terraform validate
terraform plan
# terraform apply, only after reviewing the plan
```

The SSH allow rule **requires** `ssh_source_cidr` and should be set to your trusted public IP with `/32` (for example `203.0.113.10/32`, a documentation-only address). The rule must never be set to `0.0.0.0/0`. For production, prefer a private VM and Azure Bastion, VPN, or a managed access solution.

The Azure credentials declared as Terraform variables can be provided via `TF_VAR_arm_client_id`, `TF_VAR_arm_client_secret`, `TF_VAR_arm_tenant_id`, and `TF_VAR_arm_subscription_id`; for real CI, prefer OIDC/workload identity instead of long-lived client secrets. Do not commit credentials, SSH private keys, state or personal `.tfvars`.

## Known limitations

- Current compute module creates a public IP, which increases exposure. The SSH NSG rule is scoped to a supplied CIDR but public IP deployment still needs review.
- The subnet address is hard-coded to `10.0.1.0/24`.
- The compute module protects the VM from accidental `terraform destroy` with `prevent_destroy`; modify carefully when intentionally cleaning up lab resources.
- There is no CI pipeline, automated deployment or production security baseline in this repository.

## Next steps

Parameterize the subnet CIDR, add validation/tests, and design an alternate Bastion/private-only network configuration.

## Author

[Tao Sun](https://www.linkedin.com/in/tao-sun-3437462b6/)
