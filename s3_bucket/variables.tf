variable "bucket_name" {
  description = "A name for the S3 bucket"
}

variable "acl" {
    description = "This bucket is publicv or private?"
}

variable "enable_versioning" {
    description = "Enable versioning? true or false"
}

