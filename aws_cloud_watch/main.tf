# AWS CloudWatch log group

resource "aws_cloudwatch_log_group" "code_build_group" {
    name = "${var.log_group_name}"
}