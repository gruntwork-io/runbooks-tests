# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is an example of a simple VPC configuration
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. This configuration defines common settings for all modules.
include "root" {
  path = find_in_parent_folders()
}

# This is a simple example - in production you would typically reference a module from an infrastructure catalog
terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.5.1"
}

# ---------------------------------------------------------------------------------------------------------------------
# Module parameters to pass in
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  name = "runbooks-tests-dev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Environment = "dev"
    ManagedBy   = "Terragrunt"
  }
}
