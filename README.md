# Linux & AWS Infrastructure Reliability Portfolio

**Portfolio owner:** Pranav Ranjan  
**Positioning:** Linux/Unix Administration • AWS Monitoring • Bash Automation • Terraform (learning project)

This repository contains three practical demonstration projects designed to show how I approach infrastructure operations, monitoring, automation, and repeatable cloud provisioning.

> **Important:** These are portfolio/lab projects. Replace placeholders and add your own screenshots, test evidence, and lessons learned after running them. Do not claim production results until you have personally tested and documented them.

## Projects

### 1. Linux Server Health-Check Toolkit
Path: `project-01-linux-healthcheck/`

A Bash utility that checks disk usage, memory, load average, and selected systemd services. It writes a timestamped report and supports configurable thresholds.

### 2. AWS EC2 Monitoring and Incident Alerting
Path: `project-02-aws-monitoring/`

A CloudFormation template for a small EC2 lab instance, CloudWatch CPU alarm, SNS email notification topic, and alarm configuration. Review all resource costs and security settings before deployment.

### 3. Terraform AWS Infrastructure Starter
Path: `project-03-terraform-aws/`

A small Terraform configuration that provisions a VPC, public subnet, internet gateway, route table, security group, and EC2 instance. SSH ingress is restricted to a caller-supplied CIDR. This is a learning/demo baseline, not a production-ready architecture.

## Suggested GitHub repository description

> Hands-on Linux and AWS infrastructure projects: Bash health checks, CloudWatch monitoring and alerting, and Terraform-based AWS provisioning with documentation and cleanup steps.

## Suggested next steps

1. Run Project 1 on a Linux VM and attach sample output.
2. Deploy Project 2 only in a personal AWS account, test an alarm, then delete the stack.
3. Run `terraform fmt`, `terraform validate`, and `terraform plan` for Project 3; deploy only after reviewing the plan and cost implications.
4. Add sanitized screenshots, a short architecture diagram, and a `TEST-RESULTS.md` file for each project.
5. Pin the repositories on your GitHub profile and link them from your freelance profiles.

## Security and cost rules

- Never commit AWS access keys, SSH private keys, Terraform state, `.tfvars` containing secrets, or client/employer information.
- Use MFA and least-privilege IAM.
- Set a billing alert before creating billable resources. Budget alerts do not automatically stop spending.
- Use a temporary lab environment and remove resources after testing.
- Do not run these templates in employer or client accounts without written authorization and an agreed change plan.
