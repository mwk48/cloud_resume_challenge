resource "aws_iam_openid_connect_provider" "github" {
    client_id_list = ["sts.amazonaws.com"]
    url = "https://token.actions.githubusercontent.com"
    thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github" {
  name               = "github_oidc"
  assume_role_policy = data.aws_iam_policy_document.OIDCPolicy.json
}

resource "aws_iam_role_policy_attachment" "github_attach" {
  role       = aws_iam_role.github.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "github_attach2" {
  role       = aws_iam_role.github.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "github_attach3" {
  role       = aws_iam_role.github.name
  policy_arn = data.aws_iam_policy.AdministratorAccess.arn
}


