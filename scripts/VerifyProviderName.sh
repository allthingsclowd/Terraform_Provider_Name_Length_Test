#!/usr/bin/env bash
set -x

go get ./...

export TERRAFORM_PROVIDER_NAME_TO_TEST="terraform-provider-example-with-a-really-long-name"

# Show file layout
tree

# Build test provider
go build -o ${TERRAFORM_PROVIDER_NAME_TO_TEST}

# Verify Test Provider
./${TERRAFORM_PROVIDER_NAME_TO_TEST}

# Initialise Terraform
TF_LOG=DEBUG terraform init

# Terrafrom Plan : Expect error message about missing address
echo "Expect a terraform provider warning message here"
TF_LOG=DEBUG terraform plan
