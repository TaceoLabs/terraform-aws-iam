variable "iam_role_name" {
  description = "IAM role name"
  type        = string
}

variable "iam_path" {
  description = "IAM path for OIDC role"
  type        = string
  default     = "/oidc/"
}

variable "policy_arn" {
  description = "IAM policy arn for OIDC role"
  type        = string
  default     = null
}

variable "policy_arns" {
  description = "IAM policy arns for OIDC role"
  type        = list(string)
  default     = []
}

variable "subject_values" {
  description = "Values for trust relationship conditions. See https://docs.github.com/en/actions/reference/security/oidc#example-subject-claims"
  type        = list(string)
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the specified role"
  type        = number
  default     = 3600
}

variable "ecr_push_policy" {
  description = "ECR push policy configuration for GitHub Actions OIDC role"
  type = object({
    enabled         = optional(bool, true)
    repository_arns = optional(list(string), ["*"])
    kms_key_aliases = optional(list(string), ["alias/aws/ecr"])
  })
  default = {}
}

variable "benchmark_policy" {
  description = "Benchmark policy for creating AWS resources for GitHub Actions OIDC role"
  type = object({
    enabled         = optional(bool, false)
  })
  default = {}
}