data "aws_iam_policy_document" "gel_meta_bucket_b_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::meta-efix-removal-bucket-b",
      "arn:aws:s3:::meta-efix-removal-bucket-b/*"
    ]
  }
}


resource "aws_iam_policy" "gel_meta_bucket_b_read_only" {
  name        = "gel-meta-bucket-b-read-only-group-policy"
  description = "Read Only Access to Bucket B"
  policy      = data.aws_iam_policy_document.gel_meta_bucket_b_read_only.json
}

