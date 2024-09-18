variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_description" {
  description = "The description of the API Gateway"
  type        = string
  default     = "API Gateway for decoupling"
}

# Lambda function ARN for the backend integration
variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to integrate with API Gateway"
  type        = string
}

# Lambda function name (for permissions)
variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

# List of stage names (e.g., dev, staging, prod)
variable "stage_names" {
  description = "The list of stage names for API Gateway"
  type        = list(string)
}

variable "method" {
  description = "This specifies the rest api http method"
  type        = string
  default =     "POST"
}

variable "auth" {
  description = "authorization type"
  type   = string
  default = "AWS_IAM"
}
