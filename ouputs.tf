output "local_permissions" {
  description = "Local permissions"
  value       = local.policies
}

output "aws_iam_policy_document_policies" {
  description = "AWS IAM policy document policies"
  value       = data.aws_iam_policy_document.policies
}

output "aws_iam_policy_policies" {
  description = "AWS IAM policies"
  value       = aws_iam_policy.policies
}
