variable "function_name" {
  type = string
}
variable "environment" {
  type = map(string)
}

variable "filename" {
  type = string
}

variable "timeout" {
  type = number
  default = 1
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