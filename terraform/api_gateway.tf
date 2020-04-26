resource "aws_api_gateway_rest_api" "pwa" {
  name        = "pwa"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_authorizer" "pwa" {
  name          = "pwa"
  rest_api_id   = aws_api_gateway_rest_api.pwa.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.pool.arn]
}

resource "aws_api_gateway_resource" "pwa-resource" {
  rest_api_id = aws_api_gateway_rest_api.pwa.id
  parent_id   = aws_api_gateway_rest_api.pwa.root_resource_id
  path_part   = "ride"
}

resource "aws_api_gateway_method" "pwa-method" {
  rest_api_id   = aws_api_gateway_rest_api.pwa.id
  resource_id   = aws_api_gateway_resource.pwa-resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.pwa.id
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.pwa.id
  resource_id             = aws_api_gateway_resource.pwa-resource.id
  http_method             = aws_api_gateway_method.pwa-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.pwa.invoke_arn
}

resource "aws_api_gateway_deployment" "pwa-deployment" {
  depends_on = [aws_api_gateway_integration.integration]

  rest_api_id = aws_api_gateway_rest_api.pwa.id
  stage_name  = "test"
}