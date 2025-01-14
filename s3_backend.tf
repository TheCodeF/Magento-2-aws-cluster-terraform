# Spin up neccessary resources for your terraform state
resource "aws_kms_key" "tf_state_encryption_key" {
  description             = "This key is used to encrypt tf_state bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "terraform_states" {
  bucket = "${local.project}-tf-states-backend"
}

# Enable versioning so we can see the full revision history of our
# state files
resource "aws_s3_bucket_versioning" "tf_versioning" {
  bucket = aws_s3_bucket.terraform_states.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
  bucket = aws_s3_bucket.terraform_states.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tf_state_encryption_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tf-lock-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

