data "aws_iam_policy_document" "gel_meta_bucket_a_read_write" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::meta-efix-removal-bucket-a",
      "arn:aws:s3:::meta-efix-removal-bucket-a/*"
    ]
  }
}


resource "aws_iam_policy" "gel_meta_bucket_a_read_write" {
  name        = "gel-meta-bucket-a-read-write-group-policy"
  description = "Read Only Access to Bucket A"
  policy      = data.aws_iam_policy_document.gel_meta_bucket_a_read_write.json
}
