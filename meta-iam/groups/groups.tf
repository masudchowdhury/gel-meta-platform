module "read_write_bucket_a" {
  source     = "github.com/masudchowdhury/gel-meta-platform-terraform-modules//modules/standard-group?ref=0.0.1"
  group_name = "gel-meta-read-write-bucket-a-users-group"
  path       = "/platform/"
  policy_arns = [
    "arn:aws:iam::555654209704:policy/gel-meta-bucket-a-read-write-group-policy"
  ]
}


module "read_only_bucket_b" {
  source     = "github.com/masudchowdhury/gel-meta-platform-terraform-modules//modules/standard-group?ref=0.0.1"
  group_name = "gel-meta-read-only-bucket-a-users-group"
  path       = "/platform/"
  policy_arns = [
    "arn:aws:iam::555654209704:policy/gel-meta-bucket-b-read-only-group-policy"
  ]
}