# Project 3 — Terraform AWS Infrastructure Starter

## Goal
Practice repeatable provisioning of a small AWS network and EC2 instance using Terraform.

## Resources
- VPC and public subnet
- Internet gateway and route table
- Security group with SSH ingress restricted to a supplied CIDR
- EC2 instance using a supplied AMI

## Prerequisites
- Terraform installed
- AWS CLI configured with a least-privilege lab identity
- A valid Linux AMI ID for the chosen region
- Your public IP in CIDR notation, for example `203.0.113.10/32` (replace with your actual IP; this example is documentation-only)

## Commands
```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Review the plan carefully before applying. This creates potentially billable resources.

When finished:
```bash
terraform destroy
```

## Important notes
- The EC2 instance receives a public IP, but this configuration does not create a key pair or provide SSH access credentials.
- The security group restricts SSH ingress to `allowed_ssh_cidr`; do not use `0.0.0.0/0`.
- This is a learning configuration, not a production reference architecture. Production environments should consider private subnets, Systems Manager access, NAT/egress design, flow logs, encryption, tagging standards, state locking, and policy controls.
- Terraform state can contain sensitive information. Do not commit `terraform.tfstate`, plan files, or secret variable files.
- Confirm cost and regional availability before deployment.

## Validation checklist
- [ ] `terraform fmt -check` passes.
- [ ] `terraform validate` passes.
- [ ] Review `terraform plan` and explain each resource.
- [ ] Deploy only in a personal sandbox if costs are understood.
- [ ] Verify the created resources.
- [ ] Destroy the environment and confirm cleanup.
