# Module for S3 bucket

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.bucket_name}"
    acl    = "${var.acl}"

    versioning {
        enabled = "${var.enable_versioning}"
    }
}