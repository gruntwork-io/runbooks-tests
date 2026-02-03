# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is an example of a simple S3 bucket configuration
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. This configuration defines common settings for all modules.
include "root" {
  path = find_in_parent_folders()
}

# This is a simple example - in production you would typically reference a module from an infrastructure catalog
terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.2"
}

# ---------------------------------------------------------------------------------------------------------------------
# Module parameters to pass in
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  bucket = "runbooks-tests-${get_env("USER", "example")}-prod-${get_aws_account_id()}"
  
  # Enable versioning
  versioning = {
    enabled = true
  }
  
  # Server side encryption configuration
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  
  # Block all public access
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
  # Tags
  tags = {
    Environment = "prod"
    ManagedBy   = "Terragrunt"
  }
}
