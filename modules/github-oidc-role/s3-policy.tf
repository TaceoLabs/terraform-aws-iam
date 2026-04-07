data "aws_iam_policy_document" "github_s3_policy" {
  #TODO Reduce permissions to only necessary resources
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = [var.s3_policy.bucket_arns]
  }
}

resource "aws_iam_policy" "github_s3_policy" {
  count       = var.s3_policy.enabled ? 1 : 0
  name        = "github-s3-policy"
  description = "Policy for GitHub Actions to create and destroy resources for s3's"
  policy      = data.aws_iam_policy_document.github_s3_policy.json
}

resource "aws_iam_role_policy_attachment" "github_s3_policy" {
  count      = var.s3_policy.enabled ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.github_s3_policy[0].arn
}

