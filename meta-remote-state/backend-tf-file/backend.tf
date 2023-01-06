# Use to store and manage state files for multiple Terraform configurations in different folders within the same AWS account.
terraform {
  backend "s3" {
    bucket = "gel-meta-terraform-service-state-bucket"
    key    = "./terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "gel-meta-terraform-service-state-lock-table"
    encrypt        = true
  }
}