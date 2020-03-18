# Use aws provider

provider "aws" {
  region = "us-east-1"
}

module "developement_users" {
  source        = "./users_group_membership"
  group_name    = "Developement"
  user_list     = "${var.developement_users}"
  allowed_roles = ["*"]
}

module "qa_users" {
  source        = "./users_group_membership"
  group_name    = "QA"
  user_list     = "${var.qa_users}"
  allowed_roles = ["*"]
}

# AWS S3

#module "s3_bucket" {
#  source            = "./s3_bucket"
#  bucket_name       = "${var.s3_bucket_name}"
#  acl               = "private"
#  enable_versioning = true
#}

module "aws_ecr" {
  source          = "./aws_ecr"
  repository_name = "${var.ecr_repository_name}"
}

# AWS ClowdWatch group

module "aws_cloud_watch" {
  source = "./aws_cloud_watch"
  log_group_name = "build"
}

# Create a CodeBuild project

module "test_build" {
  source       = "./code_build"
  project_name = "first_build"
  loging_group = "${module.aws_cloud_watch.cloud_watch_group_name}"
  source_type  = "BITBUCKET"
  repo_name    = "https://bitbucket.org/devops_dragrom/maven.test"
}