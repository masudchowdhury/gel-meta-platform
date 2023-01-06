variable "lambda_function_name" {
  type    = string
  default = "meta-exif-remover"
}


variable "runtime" {
  type    = string
  default = "python3.9"
}


variable "target_bucket_name" {
  type    = string
  default = "meta-efix-removal-bucket-a"
}


variable "upload_bucket_name" {
  type    = string
  default = "meta-efix-removal-bucket-b"
}


locals {
  tags = merge(
    {
      is-production    = "true"
      environment-name = "gel-meta-exif-removal"
      component        = "META-EXIF"
    }
  )
}
