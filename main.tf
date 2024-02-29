locals {
  policies = {
    for policy in var.policies : policy.iam_reference => {
      statements = {
        for index, statement in policy.statements : "statement-${index}" => {
          actions   = statement.actions
          resources = statement.resources
        }
      }
    }
  }

  policies_user = {
    for policy in var.policies : policy.iam_reference => {} if policy.iam_type == "user"
  }

  policies_role = {
    for policy in var.policies : policy.iam_reference => {} if policy.iam_type == "role"
  }
}

resource "aws_iam_policy" "policies" {
  for_each = local.policies

  name        = "policy-${each.key}"
  description = "Policy for ${each.key}"
  policy      = data.aws_iam_policy_document.policies[each.key].json
}

resource "aws_iam_user_policy_attachment" "policies" {
  for_each = local.policies_user

  user       = each.key
  policy_arn = aws_iam_policy.policies[each.key].arn
}

resource "aws_iam_role_policy_attachment" "policies" {
  for_each = local.policies_role

  role       = each.key
  policy_arn = aws_iam_policy.policies[each.key].arn
}
