# TODO: Define the variable for aws_region
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "access_key" {
  type    = string
  default = ""  
}

variable "secret_key" {
  type = string
  default = ""
}

variable "token" {
  type = string
  default = ""
}

variable "function_name" {
  type    = string
  default = "greet_lambda"
}
variable "function_runtime" {
  type    = string
  default = "python3.8"
}
variable "output_archive_name" {
  type    = string
  default = "greet_lambda.zip"
}
variable "lambda_handler" {
  type    = string
  default = "greet_lambda.lambda_handler"
}
