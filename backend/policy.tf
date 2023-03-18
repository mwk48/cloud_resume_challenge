resource "aws_iam_policy" "lambda_policy" {
    name = "lambda_policy"
    path =  "/"
    description =  "Policy for lambda"
    policy = jsonencode({
        Version =  "2012-10-17"
        Statement = [
            {
                Action = [
                    "lambda:InvokeFunction"
                ]
                Effect =  "Allow"
                Resource =  "*"
            },
        ]
    })
}

resource "aws_iam_policy" "dynamodb_policy" {
    name = "dynamodb_policy"
    path =  "/"
    description =  "Policy for dynamodb"
    policy = jsonencode({
        Version =  "2012-10-17"
        Statement = [
            {
                Action = [
                    "dynamodb:BatchGet*",
                    "dynamodb:DescribeStream",
                    "dynamodb:DescribeTable",
                    "dynamodb:Get*",
                    "dynamodb:Query",
                    "dynamodb:Scan",
                    "dynamodb:BatchWrite*",
                    "dynamodb:CreateTable",
                    "dynamodb:Delete*",
                    "dynamodb:Update*",
                    "dynamodb:PutItem"
                ]
                Effect =  "Allow"
                Resource =  "*"
            },
        ]
    })
}