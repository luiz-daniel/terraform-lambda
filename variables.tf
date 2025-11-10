variable "inline_policies" {
  type        = list(object({
    name      = string
    actions   = list(string)
    resources = list(string)
  }))
  default     = []
  description = "[OBSOLETO] Lista de políticas a serem adicionadas à função. Use `policies` em vez disso."
}

variable "policies" {
  type        = map(string)
  default     = {}
  description = "Mapa de documentos de política IAM no formato JSON, onde a chave é o nome da política."
}

variable "api" {
  type        = bool
  default     = false
  description = "Se a função será invocada pelo API Gateway."
}

variable "api_gateway_source_arn" {
  type        = string
  default     = ""
  description = "ARN do API Gateway para restringir a permissão de invocação."
}

variable "function_name" {
  type        = string
  description = "Nome da função Lambda."
}

variable "description" {
  type        = string
  default     = ""
  description = "Descrição da função Lambda."
}

variable "environment" {
  type        = map(string)
  default     = {}
  description = "Mapa de variáveis de ambiente."
}

variable "filename" {
  type        = string
  default     = null
  description = "Caminho para o arquivo de deployment da função. Use `source_code_path` para implantações baseadas em S3."
}

variable "source_code_path" {
  type        = string
  default     = null
  description = "Caminho para o diretório do código-fonte a ser compactado e implantado via S3."
}

variable "artifacts_bucket" {
  type        = string
  default     = null
  description = "Nome do bucket S3 para armazenar os artefatos de implantação da Lambda."
}

variable "timeout" {
  type        = number
  default     = 5
  description = "Tempo limite da função em segundos."
}

variable "memory" {
  type        = number
  default     = 128
  description = "Memória da função em MB."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags a serem adicionadas à função."
}

variable "handler" {
  type        = string
  default     = "bootstrap"
  description = "Handler da função."
}

variable "runtime" {
  type        = string
  default     = "provided.al2023"
  description = "Runtime da função."
}

variable "architectures" {
  type        = list(string)
  default     = ["arm64"]
  description = "Arquitetura da função."
}

variable "ephemeral_storage" {
  type        = number
  default     = 512
  description = "Armazenamento efêmero da função em MB."
}

variable "alias_name" {
  type        = string
  default     = "latest"
  description = "Nome do alias da função Lambda."
}
