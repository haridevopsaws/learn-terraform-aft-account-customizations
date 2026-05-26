data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sandbox_bucket" {
  bucket = "aft-sandbox-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_ownership_controls" "sandbox_bucket" {
  bucket = aws_s3_bucket.sandbox_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "sandbox_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.sandbox_bucket
  ]

  bucket = aws_s3_bucket.sandbox_bucket.id
  acl    = "private"
}
