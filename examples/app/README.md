# Exemplo de Aplicação Go para AWS Lambda

Este diretório contém o código-fonte de uma simples função Lambda escrita em Go.

## Compilação

Antes de implantar a função Lambda com o Terraform, você precisa compilar o código-fonte para a arquitetura da AWS Lambda.

Execute o seguinte comando a partir deste diretório (`examples/app`):

```bash
GOOS=linux GOARCH=arm64 go build -o bootstrap main.go
```

Isso criará um arquivo executável chamado `bootstrap` no diretório atual. O módulo Terraform irá então compactar este diretório (incluindo o `bootstrap` e os arquivos `.go`) e implantá-lo.
