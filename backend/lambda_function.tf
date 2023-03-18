resource "aws_lambda_function" "set_visit_count" {
    architectures                  = [
        "x86_64",
    ]
    filename                       = "set_visit_count.zip"
    function_name                  = "set_visit_count"
    source_code_hash                = data.archive_file.set_visit_count_file.output_base64sha256
    runtime                        = "python3.9"
    handler                        = "set_visit_count.lambda_handler"
    role                           = aws_iam_role.set_visit_count_role.arn
}

resource "aws_lambda_function" "get_visit_count" {
    architectures                  = [
        "x86_64",
    ]
    filename                       = "get_visit_count.zip"
    function_name                  = "get_visit_count"
    source_code_hash                = data.archive_file.get_visit_count_file.output_base64sha256
    runtime                        = "python3.9"
    handler                        = "get_visit_count.lambda_handler"
    role                           = aws_iam_role.get_visit_count_role.arn
}