module "usera" {
  source       = "github.com/masudchowdhury/gel-meta-platform-terraform-modules//modules/standard-user?ref=0.0.2"
  full_name    = "User A"
  username     = "usera"
  organisation = "GEL"
  email        = "user.a@gel.co.uk"
  group_membership = [
    "gel-meta-read-write-bucket-a-users-group"
  ]
  tags = local.tags
}


module "userb" {
  source       = "github.com/masudchowdhury/gel-meta-platform-terraform-modules//modules/standard-user?ref=0.0.2"
  full_name    = "User B"
  username     = "userb"
  organisation = "GEL"
  email        = "user.b@gel.co.uk"
  group_membership = [
    "gel-meta-read-only-bucket-a-users-group"
  ]
  tags = local.tags
}