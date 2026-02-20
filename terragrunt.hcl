terraform {
  source = "/Users/josh/Code/gruntwork-io/runbooks/testdata/test-fixtures/tofu-modules/s3-bucket"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

inputs = {
  bucket_name = "sdfasdfasdf"
  expiration_days = 0
  tags = {}
  transition_to_glacier_days = 0
  versioning_enabled = true
}
