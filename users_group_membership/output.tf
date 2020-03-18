output "group_name" {
  value = "${aws_iam_group.user_group.name}"
}

output "user_arn" {
  value = "${aws_iam_user.aws_username.*.arn}"
}