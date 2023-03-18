
module "cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"

  api_id          = aws_api_gateway_rest_api.api.id
  api_resource_id = aws_api_gateway_rest_api.api.root_resource_id
}

resource "aws_api_gateway_rest_api" "api" {
  name = "cloud-resume"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  description = ""
}


resource "aws_api_gateway_method" "method" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_rest_api.api.root_resource_id
  http_method = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_rest_api.api.root_resource_id
  http_method = aws_api_gateway_method.method.http_method
  type = "AWS_PROXY"
  integration_http_method = "POST"
  uri = aws_lambda_function.set_visit_count.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_api_gateway_integration.integration]
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_rest_api.api.root_resource_id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
}

resource "aws_api_gateway_stage" "stage" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name = "v1"
  deployment_id = aws_api_gateway_deployment.deployment.id
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.set_visit_count.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${local.region}:${local.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}/"
}

resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.stage.stage_name
  method_path = "*/*"

  settings {
    throttling_burst_limit = 10
    throttling_rate_limit = 1
  }
}
