# AWS CodeBuild module

# Create code_build role

resource "aws_iam_role" "code_build" {
  name               = "code_build"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "code_build" {
  role   = "${aws_iam_role.code_build.name}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "logs:CreateLogStream",
                "codebuild:UpdateReport",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation",
                "codebuild:BatchPutTestCases",
                "logs:PutLogEvents",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudtrail:LookupEvents",
                "ecr:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_codebuild_project" "example" {
  name          = "${var.project_name}"
  build_timeout = "5"
  service_role  = "${aws_iam_role.code_build.arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.loging_group}"
    }
  }

  source {
    type            = "${var.source_type}"
    location        = "${var.repo_name}"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = "master"
}