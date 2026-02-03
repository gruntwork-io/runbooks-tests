# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# root.hcl configuration.
locals {
  account_name   = "dev"
  aws_account_id = "111111111111" # TODO: replace me with your AWS account ID!
}
