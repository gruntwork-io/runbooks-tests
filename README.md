# Simplified Infrastructure-Live Example

This is a simplified infrastructure-live repository for testing purposes with [Gruntwork Runbooks](https://github.com/gruntwork-io/runbooks). It implements the basic patterns of organizing Infrastructure as Code (IaC) with Terragrunt.

This repository is modeled after [terragrunt-infrastructure-live-stacks-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-stacks-example) but simplified for ease of use in creating pull requests, launching modules, and testing infrastructure workflows.

## What is an `infrastructure-live` repository?

An `infrastructure-live` repository contains the "live" infrastructure configurations - the actual infrastructure that is provisioned. This is different from an `infrastructure-catalog` repository which contains reusable infrastructure patterns such as OpenTofu/Terraform modules.

## Prerequisites

To use this repository, install:

- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [OpenTofu](https://opentofu.org/docs/intro/install/)

Or use [mise](https://mise.jdx.dev/) to install all tools with pinned versions:

```bash
mise install
```

## Setup

Before provisioning infrastructure:

1. **Update S3 bucket name** in `root.hcl` (line 39) to ensure uniqueness:
   ```hcl
   bucket = "${get_env("TG_BUCKET_PREFIX", "")}runbooks-tests-tf-state-${local.account_name}-${local.aws_region}"
   ```

2. **Update AWS account IDs** in `dev/account.hcl` and `prod/account.hcl`:
   ```hcl
   aws_account_id = "123456789012"  # Replace with your account ID
   ```

3. **Configure AWS credentials** using one of the [supported methods](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

## Usage Examples

### Deploy a single module

```bash
# Navigate to the module directory
cd dev/us-east-1/s3-bucket

# Plan the changes
terragrunt plan

# Apply the changes
terragrunt apply
```