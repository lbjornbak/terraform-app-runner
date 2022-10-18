terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
  }
  backend "s3" {
    bucket = "pgr301-2021-terraform-state"
    key    = "kinglors/apprunner-lab.state"
    region = "eu-north-1"
  }
}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

variable "bucket_name" {
  default = "larsman-s3-bucket"
  type = string
}
