# Módulo Terraform para AWS Lambda

Este módulo Terraform implanta uma função AWS Lambda com as seguintes características:

- Suporte para políticas personalizadas.
- Alias para a versão mais recente da função.
- Políticas de execução básicas para o Lambda e AWS X-Ray.
- Permissão para invocação pelo API Gateway.

## Exemplo de Uso

```hcl
data "aws_iam_policy_document" "s3_access" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::meu-bucket/*"]
  }
}

module "lambda" {
  source = "./"

  function_name = "minha-funcao-lambda"
  filename      = "lambda.zip"

  policies = {
    "s3-access" = data.aws_iam_policy_document.s3_access.json
  }
}
```

## Entradas

| Nome | Descrição | Tipo | Padrão | Obrigatório |
| --- | --- | --- | --- | --- |
| `alias_name` | Nome do alias da função Lambda. | `string` | `"latest"` | não |
| `api` | Se a função será invocada pelo API Gateway. | `bool` | `false` | não |
| `api_gateway_source_arn` | ARN do API Gateway para restringir a permissão de invocação. | `string` | `""` | não |
| `architectures` | Arquitetura da função. | `list(string)` | `["arm64"]` | não |
| `description` | Descrição da função Lambda. | `string` | `""` | não |
| `environment` | Mapa de variáveis de ambiente. | `map(string)` | `{}` | não |
| `ephemeral_storage` | Armazenamento efêmero da função em MB. | `number` | `512` | não |
| `filename` | Caminho para o arquivo de deployment da função. | `string` | `"./lambda.zip"` | não |
| `function_name` | Nome da função Lambda. | `string` | n/a | sim |
| `handler` | Handler da função. | `string` | `"bootstrap"` | não |
| `inline_policies` | [OBSOLETO] Lista de políticas a serem adicionadas à função. Use `policies` em vez disso. | `list(object({ name = string, actions = list(string), resources = list(string) }))` | `[]` | não |
| `memory` | Memória da função em MB. | `number` | `128` | não |
| `policies` | Mapa de documentos de política IAM no formato JSON, onde a chave é o nome da política. | `map(string)` | `{}` | não |
| `runtime` | Runtime da função. | `string` | `"provided.al2023"` | não |
| `tags` | Tags a serem adicionadas à função. | `map(string)` | `{}` | não |
| `timeout` | Tempo limite da função em segundos. | `number` | `5` | não |

## Saídas

| Nome          | Descrição                      |
| ------------- | ------------------------------ |
| `function_name` | Nome da função Lambda.         |
| `arn`         | ARN da função Lambda.          |
