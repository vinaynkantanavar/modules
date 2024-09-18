resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = var.api_description
  body        = file(var.openapi_file) # If you want to pass an OpenAPI file directly
}

# Create a Lambda integration
resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_rest_api.this.root_resource_id
  http_method   = var.method
  authorization = var.auth
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_rest_api.this.root_resource_id
  http_method = aws_api_gateway_method.proxy_method.http_method
  integration_http_method = var.method
  type        = "AWS_PROXY"
  uri         = var.lambda_function_arn
}

# Create a deployment for the API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  depends_on  = [aws_api_gateway_integration.lambda_integration]
}

# Dynamically create multiple stages
resource "aws_api_gateway_stage" "api_stages" {
  for_each    = toset(var.stage_names)
  
  rest_api_id = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  stage_name  = each.key

  description = "API stage for ${each.key} environment"
  variables = {
    "stage" = each.key
  }
}

# Create permissions for Lambda to be invoked by API Gateway
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = aws_api_gateway_rest_api.this.execution_arn
}
