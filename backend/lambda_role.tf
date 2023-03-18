resource "aws_iam_role" "set_visit_count_role" {
  name               = "set_visit_count_role"
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
}

resource "aws_iam_role" "get_visit_count_role" {
  name               = "get_visit_count_role"
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
}

resource "aws_iam_role_policy_attachment" "set_visit_count_attach" {
  role       = aws_iam_role.set_visit_count_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "set_visit_count_attach2" {
  role       = aws_iam_role.set_visit_count_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "get_visit_count_attach" {
  role       = aws_iam_role.get_visit_count_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}
