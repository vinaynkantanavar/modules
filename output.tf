output "rest_api_id" {
  value = aws_api_gateway_rest_api.this.id
}

# Output the stage invoke URLs
output "stage_invoke_urls" {
  description = "Invoke URLs for each API stage"
  value = {
    for stage in aws_api_gateway_stage.api_stages : stage.stage_name => "https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${stage.stage_name}"
  }
}

output "deployment_api_id" {
  value = aws_api_gateway_deployment.api_deployment.id
}
