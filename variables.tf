variable "developement_users" {
  type    = list(string)
  default = ["user1", "user2"]
}

variable "qa_users" {
  type    = list(string)
  default = ["user3", "user4"]
}

variable "s3_bucket_name" {
  description = "The S3 bucket"
  default     = "my-personal-bucket"
}

variable "ecr_repository_name" {
  description = "AWS ECR repository name"
  default     = "my_repo"
}