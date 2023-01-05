terraform {
  backend "s3" {
    bucket = "gel-meta-terraform-service-state-bucket"
    key    = "./terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "gel-meta-terraform-service-lock-table"
    encrypt        = true
  }
}