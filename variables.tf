variable "inline_policies" {
  type        = list(object({
    name      = string
    actions   = list(string)
    resources = list(string)
  }))
  default     = []
}

variable "api" {
  type = bool
  default = false
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "function_name" {
  type = string
}

variable "environment" {
  type = map(string)
}

variable "filename" {
  type = string
  default = "./lambda.zip"
}

variable "timeout" {
  type = number
  default = 5
}

variable "memory" {
  type = number
  default = 128
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "handler" {
  type = string
  default = "bootstrap"
}

variable "runtime" {
  type = string
  default = "provided.al2023"
}

variable "architectures" {
  default = ["arm64"]
}
