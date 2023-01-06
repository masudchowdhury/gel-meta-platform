locals {
  tags = merge(
    {
      is-production    = "true"
      environment-name = "gel-iam"
      component        = "IAM"
    }
  )
}
