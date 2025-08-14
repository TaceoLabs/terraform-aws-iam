data "aws_iam_policy_document" "github_benchmark_policy" {
  # TODO drastically reduce permissions to EC2 creation, VPC creation, ..
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "github_benchmark_policy" {
  count       = var.benchmark_policy.enabled ? 1 : 0
  name        = "github-benchmark-policy"
  description = "Policy for GitHub Actions to create and destroy resources for benchmarks"
  policy      = data.aws_iam_policy_document.github_benchmark_policy.json
}

resource "aws_iam_role_policy_attachment" "github_benchmark_policy" {
  count      = var.benchmark_policy.enabled ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.github_benchmark_policy[0].arn
}
