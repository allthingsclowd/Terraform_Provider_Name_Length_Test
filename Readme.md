# Testing long Terraform Provider Module Names

A customer recently asked was it possible when naming Provider Modules, which HashiCorp documents as __terraform-<Provider>-<Name>__ e.g. terraform-provider-example, could the __<Name>__ also include multiple sections broken by a '-'.

HashiCorp has made it very easy to prototype and build new modules which is documented (here) 
[https://www.terraform.io/guides/writing-custom-terraform-providers.html]

And this repo simply implements the example found there, but with a-really-long-dashed-name.

So in conclusion, yes, you can indeed include multiple '-'s in the __<Name>__ component for a custom provider!

To try out your own provider names simply:
- install Go
- install Terrafrom
- clone this repository
- change to the directory where main.tf exists
- edit scripts/VerifyProviderName.sh and set
```bash
export TERRAFORM_PROVIDER_NAME_TO_TEST="terraform-provider-example-with-a-really-long-name"
```
- also edit the provider.go file
``` go
package main

import (
        "github.com/hashicorp/terraform/helper/schema"
)

func Provider() *schema.Provider {
	return &schema.Provider{
			ResourcesMap: map[string]*schema.Resource{
					"example-with-a-really-long-name_server": resourceServer(),
			},
	}
}
```

## Example output

``` bash
Grahams-MacBook-Pro:terraform-provider-demo grazzer$ ./scripts/VerifyProviderName.sh
+ go get ./...
go get: no install location for directory /Users/grazzer/vagrant_workspace/terraform-provider-demo outside GOPATH
	For more details see: 'go help gopath'
+ export TERRAFORM_PROVIDER_NAME_TO_TEST=terraform-provider-example-with-a-really-long-name
+ TERRAFORM_PROVIDER_NAME_TO_TEST=terraform-provider-example-with-a-really-long-name
+ tree
.
├── Readme.md
├── main.go
├── main.tf
├── provider.go
├── resource_server.go
└── scripts
    └── VerifyProviderName.sh

1 directory, 6 files
+ go build -o terraform-provider-example-with-a-really-long-name
+ ./terraform-provider-example-with-a-really-long-name
This binary is a plugin. These are not meant to be executed directly.
Please execute the program that consumes these plugins, which will
load any plugins automatically
+ TF_LOG=DEBUG
+ terraform init
2018/10/11 10:46:57 [INFO] Terraform version: 0.11.8
2018/10/11 10:46:57 [INFO] Go runtime version: go1.10.3
2018/10/11 10:46:57 [INFO] CLI args: []string{"/usr/local/Cellar/terraform/0.11.8/bin/terraform", "init"}
2018/10/11 10:46:57 [DEBUG] Attempting to open CLI config file: /Users/grazzer/.terraformrc
2018/10/11 10:46:57 [DEBUG] File doesn't exist, but doesn't need to. Ignoring.
2018/10/11 10:46:57 [INFO] CLI command args: []string{"init"}
2018/10/11 10:46:57 [DEBUG] command: loading backend config file: /Users/grazzer/vagrant_workspace/terraform-provider-demo
2018/10/11 10:46:57 [INFO] command: empty terraform config, returning nil
2018/10/11 10:46:57 [DEBUG] command: no data state file found for backend config
2018/10/11 10:46:57 [DEBUG] New state was assigned lineage "24efb07b-8e6d-67e9-41e1-7fa8e83463df"
2018/10/11 10:46:57 [INFO] command: backend initialized: <nil>
2018/10/11 10:46:57 [DEBUG] checking for provider in "."
2018/10/11 10:46:57 [WARN] found legacy provider "terraform-provider-example-with-a-really-long-name"
2018/10/11 10:46:57 [DEBUG] checking for provider in "/usr/local/Cellar/terraform/0.11.8/bin"
2018/10/11 10:46:57 [DEBUG] found valid plugin: "example-with-a-really-long-name", "0.0.0", "/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name"
2018/10/11 10:46:57 [DEBUG] checking for provisioner in "."
2018/10/11 10:46:57 [DEBUG] checking for provisioner in "/usr/local/Cellar/terraform/0.11.8/bin"
2018/10/11 10:46:57 [INFO] Failed to read plugin lock file .terraform/plugins/darwin_amd64/lock.json: open .terraform/plugins/darwin_amd64/lock.json: no such file or directory
2018/10/11 10:46:57 [INFO] command: backend <nil> is not enhanced, wrapping in local
2018/10/11 10:46:57 [DEBUG] checking for provider in "."
2018/10/11 10:46:57 [WARN] found legacy provider "terraform-provider-example-with-a-really-long-name"
2018/10/11 10:46:57 [DEBUG] checking for provider in "/usr/local/Cellar/terraform/0.11.8/bin"
2018/10/11 10:46:57 [DEBUG] found valid plugin: "example-with-a-really-long-name", "0.0.0", "/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name"
2018/10/11 10:46:57 [DEBUG] plugin requirements: "example-with-a-really-long-name"=""

2018/10/11 10:46:57 [DEBUG] checking for provider in "."
Initializing provider plugins...
2018/10/11 10:46:57 [WARN] found legacy provider "terraform-provider-example-with-a-really-long-name"
2018/10/11 10:46:57 [DEBUG] checking for provider in "/usr/local/Cellar/terraform/0.11.8/bin"
2018/10/11 10:46:57 [DEBUG] found valid plugin: "example-with-a-really-long-name", "0.0.0", "/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name"

2018/10/11 10:46:57 [DEBUG] checking for provider in ".terraform/plugins/darwin_amd64"
2018/10/11 10:46:57 [DEBUG] plugin: waiting for all plugin processes to complete...
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
+ echo 'Expect a terraform provider warning message here'
Expect a terraform provider warning message here
+ TF_LOG=DEBUG
+ terraform plan
2018/10/11 10:46:57 [INFO] Terraform version: 0.11.8
2018/10/11 10:46:57 [INFO] Go runtime version: go1.10.3
2018/10/11 10:46:57 [INFO] CLI args: []string{"/usr/local/Cellar/terraform/0.11.8/bin/terraform", "plan"}
2018/10/11 10:46:57 [DEBUG] Attempting to open CLI config file: /Users/grazzer/.terraformrc
2018/10/11 10:46:57 [DEBUG] File doesn't exist, but doesn't need to. Ignoring.
2018/10/11 10:46:57 [INFO] CLI command args: []string{"plan"}
2018/10/11 10:46:57 [INFO] command: empty terraform config, returning nil
2018/10/11 10:46:57 [DEBUG] command: no data state file found for backend config
2018/10/11 10:46:57 [DEBUG] New state was assigned lineage "84591bae-9081-54bc-fbc1-090f60943545"
2018/10/11 10:46:57 [INFO] command: backend initialized: <nil>
2018/10/11 10:46:57 [DEBUG] checking for provider in "."
2018/10/11 10:46:57 [WARN] found legacy provider "terraform-provider-example-with-a-really-long-name"
2018/10/11 10:46:57 [DEBUG] checking for provider in "/usr/local/Cellar/terraform/0.11.8/bin"
2018/10/11 10:46:57 [DEBUG] checking for provider in ".terraform/plugins/darwin_amd64"
2018/10/11 10:46:57 [DEBUG] found valid plugin: "example-with-a-really-long-name", "0.0.0", "/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name"
2018/10/11 10:46:57 [DEBUG] checking for provisioner in "."
2018/10/11 10:46:57 [DEBUG] checking for provisioner in "/usr/local/Cellar/terraform/0.11.8/bin"
2018/10/11 10:46:57 [DEBUG] checking for provisioner in ".terraform/plugins/darwin_amd64"
2018/10/11 10:46:58 [INFO] command: backend <nil> is not enhanced, wrapping in local
2018/10/11 10:46:58 [INFO] backend/local: starting Plan operation
2018/10/11 10:46:58 [DEBUG] New state was assigned lineage "cac82d01-5a69-ed45-ad9b-bc07cd1020af"
2018/10/11 10:46:58 [INFO] terraform: building graph: GraphTypeInput
2018/10/11 10:46:58 [DEBUG] Resource state not found for "example-with-a-really-long-name_server.my-server": example-with-a-really-long-name_server.my-server
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.AttachStateTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeAbstractResource
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.RootVariableTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeAbstractResource
2018/10/11 10:46:58 [TRACE] ProviderConfigTransformer: Starting for path: []
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.ProviderConfigTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeAbstractResource
2018/10/11 10:46:58 [DEBUG] adding missing provider: example-with-a-really-long-name
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.MissingProviderTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeAbstractResource
provider.example-with-a-really-long-name - *terraform.NodeApplyableProvider
2018/10/11 10:46:58 [DEBUG] resource example-with-a-really-long-name_server.my-server using provider provider.example-with-a-really-long-name
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.ProviderTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeAbstractResource
  provider.example-with-a-really-long-name - *terraform.NodeApplyableProvider
provider.example-with-a-really-long-name - *terraform.NodeApplyableProvider
2018/10/11 10:46:58 [DEBUG] ReferenceTransformer: "provider.example-with-a-really-long-name" references: []
2018/10/11 10:46:58 [DEBUG] ReferenceTransformer: "example-with-a-really-long-name_server.my-server" references: []
2018-10-11T10:46:58.072+0100 [DEBUG] plugin: starting plugin: path=/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name args=[/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name]
2018-10-11T10:46:58.075+0100 [DEBUG] plugin: waiting for RPC address: path=/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name
2018-10-11T10:46:58.092+0100 [DEBUG] plugin.terraform-provider-example-with-a-really-long-name: plugin address: timestamp=2018-10-11T10:46:58.092+0100 address=/var/folders/lm/nxj5y0qs52xb620c8t793x040000gn/T/plugin141859314 network=unix
2018/10/11 10:46:58 [INFO] terraform: building graph: GraphTypeValidate
2018/10/11 10:46:58 [DEBUG] Resource state not found for "example-with-a-really-long-name_server.my-server": example-with-a-really-long-name_server.my-server
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.AttachStateTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeValidatableResource
2018/10/11 10:46:58 [DEBUG] ReferenceTransformer: "example-with-a-really-long-name_server.my-server" references: []
2018/10/11 10:46:58 [DEBUG] ReferenceTransformer: "provider.example-with-a-really-long-name" references: []
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.ReferenceTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeValidatableResource
  provider.example-with-a-really-long-name - *terraform.NodeApplyableProvider
provider.example-with-a-really-long-name - *terraform.NodeApplyableProvider
2018/10/11 10:46:58 [DEBUG] Resource state not found for "example-with-a-really-long-name_server.my-server": example-with-a-really-long-name_server.my-server
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.AttachStateTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeValidatableResourceInstance
2018/10/11 10:46:58 [TRACE] Graph after step *terraform.TargetsTransformer:

example-with-a-really-long-name_server.my-server - *terraform.NodeValidatableResourceInstance
2018/10/11 10:46:58 [DEBUG] ReferenceTransformer: "example-with-a-really-long-name_server.my-server" references: []
2018/10/11 10:46:58 [ERROR] root: eval: *terraform.EvalValidateResource, err: Warnings: []. Errors: ["address": required field is not set]
2018/10/11 10:46:58 [ERROR] root: eval: *terraform.EvalSequence, err: Warnings: []. Errors: ["address": required field is not set]
2018/10/11 10:46:58 [TRACE] [walkValidate] Exiting eval tree: example-with-a-really-long-name_server.my-server
2018/10/11 10:46:58 [DEBUG] plugin: waiting for all plugin processes to complete...

Error: example-with-a-really-long-name_server.my-server: "address": required field is not set


2018-10-11T10:46:58.099+0100 [DEBUG] plugin.terraform-provider-example-with-a-really-long-name: 2018/10/11 10:46:58 [ERR] plugin: plugin server: accept unix /var/folders/lm/nxj5y0qs52xb620c8t793x040000gn/T/plugin141859314: use of closed network connection
2018-10-11T10:46:58.100+0100 [DEBUG] plugin: plugin process exited: path=/Users/grazzer/vagrant_workspace/terraform-provider-demo/terraform-provider-example-with-a-really-long-name
```