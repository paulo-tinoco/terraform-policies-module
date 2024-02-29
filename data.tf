data "aws_iam_policy_document" "policies" {
  for_each = local.policies

  dynamic "statement" {
    for_each = each.value.statements
    content {
      effect    = "Allow"
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}
