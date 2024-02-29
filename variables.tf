variable "region" {
  description = "The region in which resources will be created"
  type        = string
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "policies" {
  description = "The permissions to grant to the Lambda function"
  type = list(object({
    iam_reference = string
    iam_type      = string
    statements = list(object({
      actions   = list(string)
      resources = list(string)
    }))
  }))
}
