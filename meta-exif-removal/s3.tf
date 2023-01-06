module "bucket_a" {
  source = "github.com/masudchowdhury/gel-meta-platform-terraform-modules//modules/standard-s3-bucket?ref=0.0.1"
  name   = var.target_bucket_name
  tags   = local.tags
}


module "bucket_b" {
  source = "github.com/masudchowdhury/gel-meta-platform-terraform-modules//modules/standard-s3-bucket?ref=0.0.1"
  name   = var.upload_bucket_name
  tags   = local.tags
}