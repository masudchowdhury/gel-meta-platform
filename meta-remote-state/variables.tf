locals {
  # --- Define tags that will be applied to the s3 bucket and dynamodb table responsible for state management
  tags = merge(
    {
      is-production    = "true"
      environment-name = "gel-meta-iam"
      component        = "Terraform Management"
    }
  )
}