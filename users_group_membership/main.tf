#
# IAM group + membership
#

# Create IAM group
resource "aws_iam_group" "user_group" {
  name = var.group_name
}

# Creat IAM user
resource "aws_iam_user" "aws_username" {
  count = "${length(var.user_list)}"
  name  = "${element(var.user_list,count.index)}"
}

resource "aws_iam_group_membership" "user_group" {
  name  = "${var.group_name}-membership"
  users = var.user_list

  group = aws_iam_group.user_group.name
}

#
# IAM policy to allow the user group to assume the role passed to the module
#

data "aws_iam_policy_document" "assume_role_policy_doc" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = var.allowed_roles
  }
}

resource "aws_iam_policy" "assume_role_policy" {
  name        = "assume-role-${aws_iam_group.user_group.name}"
  path        = "/"
  description = "Allows the ${aws_iam_group.user_group.name} role to be assumed."
  policy      = data.aws_iam_policy_document.assume_role_policy_doc.json
}

resource "aws_iam_group_policy_attachment" "assume_role_policy_attachment" {
  group      = aws_iam_group.user_group.name
  policy_arn = aws_iam_policy.assume_role_policy.arn
}
