package main

import (
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

func HandleRequest() (string, error) {
	return fmt.Sprintf("Hello from Go!"), nil
}

func main() {
	lambda.Start(HandleRequest)
}
