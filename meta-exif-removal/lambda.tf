data "aws_iam_policy_document" "lambda_policy" {
  statement {
    sid = "AllowsListBucketForRoot"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      module.bucket_a.arn,
      module.bucket_b.arn
    ]
  }

  statement {
    sid = "AllowGetObjectActionsForReadBuckets"
    actions = [
      "s3:GetObject"
    ]
    effect = "Allow"
    resources = concat(
      [
        module.bucket_a.arn
      ],
      [
        "${module.bucket_a.arn}/*"
      ]
    )
  }

  statement {
    sid = "AllowPutObjectActionsForWriteBuckets"
    actions = [
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = concat(
      [
        module.bucket_b.arn
      ],
      [
        "${module.bucket_b.arn}/*"
      ]
    )
  }
}


module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_function_name
  description   = "remove EXIF data from images"
  handler       = "exif_remover.handler"
  runtime       = var.runtime
  source_path = [{
    path = "${path.module}/src"
  }]
  timeout = 10

  environment_variables = {
    target_bucket_name = module.bucket_b.id
  }

  attach_policy_json = true
  policy_json        = data.aws_iam_policy_document.lambda_policy.json

  create_current_version_allowed_triggers = false
  allowed_triggers = {
    AllowExecutionFromS3Bucket = {
      service    = "s3"
      source_arn = module.bucket_a.arn
    }
  }

  layers = [aws_lambda_layer_version.lambda_layer.arn]

  tags = local.tags
}


resource "aws_lambda_layer_version" "lambda_layer" {
  filename            = "src/exifLayer.zip"
  source_code_hash    = filebase64sha256("${path.module}/src/exifLayer.zip")
  layer_name          = "lambda_layer"
  compatible_runtimes = ["python3.9"]
}


resource "aws_s3_bucket_notification" "upload_notification" {
  bucket = module.bucket_a.id
  lambda_function {
    lambda_function_arn = module.lambda_function.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".jpg"
  }

  depends_on = [module.lambda_function]
}