# GEL-meta-Platform

This repository contains a simple Lambda function in the `meta-exif-removal` folder to extract EXIF data from images uploaded to a source S3 `(bucket A)` and store it in the target S3 `(bucket B)`. 

Flow: [Image Uploaded To S3 Bucket A] -> [S3 Event Notification] -> [Lambda Function] -> [Image Uploaded To S3 Bucket B]

It also has an IAM folder (`meta-iam`) where policies, groups and users can be configured. At the moment it has two users: `User A` and `User B`. They both have specific groups attachments granting RW and R access to bucket A and bucket B respectively.

This repository consumes modules from [gel-meta-platform-terraform-modules](https://github.com/masudchowdhury/gel-meta-platform-terraform-modules).

## Deployment 

`Optional`: A meta-remote-state folder has been defined to configure a remote backend using AWS S3 + DynamoDB. This infrastructure should be built first with the terraform state file stored locally and the `/meta-remote-state/backend-tf-file/backend.tf` file copied to other seperate folders.

To build, configure aws cli then run `terraform init` -> `terraform plan` -> `terraform apply` in the folders in the following order 
- `/meta-exif-removal`
- `/meta-iam/policies`
- `/meta-iam/groups`
- `/meta-iam/users`
