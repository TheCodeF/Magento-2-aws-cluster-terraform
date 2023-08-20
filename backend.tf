# # Comment out this block on first deploy to generate the s3 bucket and dynamo table.
# # We will be able to import them later and rerun this code once they exist
# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket                  = "${local.project}-tf-states-backend"
#     key                     = "main.tf"
#     region                  = "me-south-1"
#     encrypt                 = true
#     profile                 = "default"
#     dynamodb_table          = "tf-lock-table"
#     shared_credentials_file = "$HOME/.aws/credentials"
#   }
# }