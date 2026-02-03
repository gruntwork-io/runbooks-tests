# Simplified Infrastructure-Live Example

This is a simplified infrastructure-live repository for testing and learning purposes. It demonstrates the basic patterns of organizing Infrastructure as Code (IaC) with Terragrunt, without the complexity of production-grade best practices.

This repository is modeled after [terragrunt-infrastructure-live-stacks-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-stacks-example) but simplified for ease of use in creating pull requests, launching modules, and testing infrastructure workflows.

## What is an `infrastructure-live` repository?

An `infrastructure-live` repository contains the "live" infrastructure configurations - the actual infrastructure that is provisioned. This is different from an `infrastructure-catalog` repository which contains reusable infrastructure patterns.

## Repository Structure

```
.
├── root.hcl                    # Root Terragrunt configuration
├── mise.toml                   # Tool version pinning (Terragrunt, OpenTofu)
├── dev/                        # Dev account
│   ├── account.hcl            # Account-specific configuration
│   └── us-east-1/             # AWS region
│       ├── region.hcl         # Region-specific configuration
│       ├── s3-bucket/         # Simple S3 bucket example
│       │   └── terragrunt.hcl
│       └── vpc/               # Simple VPC example
│           └── terragrunt.hcl
└── prod/                       # Prod account
    ├── account.hcl            # Account-specific configuration
    └── us-east-1/             # AWS region
        ├── region.hcl         # Region-specific configuration
        ├── s3-bucket/         # Simple S3 bucket example
        │   └── terragrunt.hcl
        └── vpc/               # Simple VPC example
            └── terragrunt.hcl
```

## Key Files

- **`root.hcl`**: Root Terragrunt configuration that is included by all modules. Defines:
  - AWS provider configuration
  - Remote state backend (S3)
  - Common inputs available to all modules

- **`account.hcl`**: Account-level configuration (account name and AWS account ID)

- **`region.hcl`**: Region-level configuration (AWS region)

- **`terragrunt.hcl`**: Module-specific configuration that includes the root config and defines module source and inputs

## Prerequisites

To use this repository, install:

- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [OpenTofu](https://opentofu.org/docs/intro/install/) or [Terraform](https://developer.hashicorp.com/terraform/install)

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

### Deploy all modules in an environment

```bash
# From the environment root (e.g., dev/us-east-1)
cd dev/us-east-1
terragrunt run-all plan
terragrunt run-all apply
```

### Destroy resources

```bash
# Single module
cd dev/us-east-1/s3-bucket
terragrunt destroy

# All modules
cd dev/us-east-1
terragrunt run-all destroy
```

## Examples Included

### S3 Bucket Example (`s3-bucket/`)

A simple S3 bucket with:
- Versioning enabled
- Server-side encryption (AES256)
- Public access blocked
- Environment-specific tags

### VPC Example (`vpc/`)

A basic VPC with:
- 3 availability zones
- Public and private subnets
- NAT Gateway enabled
- Environment-specific CIDR ranges

## How This Differs from the Full Example

This simplified version:

- ✅ Uses simple, standalone modules instead of complex stacks
- ✅ Leverages public Terraform modules from the registry
- ✅ Has minimal configuration files
- ✅ Focuses on demonstrating basic patterns
- ✅ Easy to understand and modify

The full [terragrunt-infrastructure-live-stacks-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-stacks-example):

- Uses Terragrunt Stacks for complex multi-component deployments
- References modules from a separate infrastructure-catalog repository
- Includes production-grade security and best practices
- Demonstrates inter-module dependencies

## Next Steps

- Modify the examples to match your needs
- Add more modules (RDS, ECS, Lambda, etc.)
- Create pull requests to test infrastructure changes
- Experiment with different Terragrunt features

## Resources

- [Terragrunt Documentation](https://terragrunt.gruntwork.io/)
- [Terragrunt Quick Start](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/)
- [Terraform AWS Modules](https://registry.terraform.io/namespaces/terraform-aws-modules)
