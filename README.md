# Terraform Policies Module

Terraform module to create policy and role dynamically.

## Usage

```hcl
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "policies" {
  source = "../"

  region     = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id

  policies = [
    {
      iam_reference = "username-iam"
      iam_type      = "user"
      statements = [
        {
          actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
          resources = ["arn:aws:s3:::callwe-integration-service/*"]
        },
        {
          actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
          resources = ["arn:aws:logs:us-east-1:123456789012:log-group:/aws/lambda/*"]
        }
      ]
    },
    {
      iam_reference = "lambda-role-name"
      iam_type      = "role"
      statements = [
        {
          actions = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
          resources = [
            "arn:aws:s3:::callwe-integration-service/*",
            "arn:aws:s3:::callwe-integration-service-dev/*"
          ]
        },
        {
          actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
          resources = ["arn:aws:logs:us-east-1:123456789012:log-group:/aws/lambda/*"]
        }
      ]
    },
  ]
}
```
