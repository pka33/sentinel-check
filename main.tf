#sentinel policy
provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-sentinel"

  #tags = {
  #  Name        = "My bucket"
  #  Environment = "Dev"
  #}

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}