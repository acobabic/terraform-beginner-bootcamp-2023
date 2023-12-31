# Terraform Beginner Bootcamp 2023 - Week 1

- [Root Module Structure](#root-module-structure)
- [Terraform Variables](#terraform-variables)
  * [Terraform Cloud Variables](#terraform-cloud-variables)
  * [Loading Terraform Variables](#loading-terraform-variables)
    + [var flag](#var-flag)
    + [var-file flag](#var-file-flag)
    + [terraform.tfvars](#terraformtfvars)
    + [auto.tfvars](#autotfvars)
    + [order of terraform variable](#order-of-terraform-variable)
- [Dealing with configuration drift](#dealing-with-configuration-drift)
  * [What happens if we lose our state file?](#what-happens-if-we-lose-our-state-file-)
  * [Fix Missing Resources with Terraform Import](#fix-missing-resources-with-terraform-import)
  * [Fix Manual Configuration](#fix-manual-configuration)
  * [Fix using Terraform Refresh](#fix-using-terraform-refresh)
- [Terraform Modules](#terraform-modules)
  * [Terraform Module Structure](#terraform-module-structure)
  * [Modules Sources](#modules-sources)
  * [Passing Input Variables](#passing-input-variables)
- [ChatGPT for writing Terraform](#chatgpt-for-writing-terraform)
- [Working with files in Terraform](#working-with-files-in-terraform)
  * [Fileexists function](#fileexists-function)
  * [Filemd5 function](#filemd5-function)
  * [Path Variable](#path-variable)
- [Working with data in Terraform](#working-with-data-in-terraform)
  * [Terraform Locals](#terraform-locals)
  * [Terraform Data Sources](#terraform-data-sources)
  * [Woking with JSON](#woking-with-json)
  * [Changing the Lifecycle of Resources](#changing-the-lifecycle-of-resources)
  * [Terraform Data Resource](#terraform-data-resource)
- [Terraform Provisioners](#terraform-provisioners)
  * [file provisioner](#file-provisioner)
  * [local-exec](#local-exec)
  * [remote-exec](#remote-exec)
    + [HereDoc](#heredoc)
- [Terraform for_each](#terraform-for-each)
- [Terraform fileset](#terraform-fileset)


## Root Module Structure

Our root module structure is as follows:

```
- PROJECT ROOT
  |
  |-- main.tf            # everything else
  |-- variables.tf       # stores the structure of input variables
  |-- terraform.tfvars   # the data of variable we want to load into our terraform project
  |-- providers.tf       # defines required providers and their configuration
  |-- outputs.tf         # stores our outputs
  |-- README.md          # required for root module
```

[Terraform Standard Module Structure Docs](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform Variables

### Terraform Cloud Variables

In Terraform Cloud we can set two type of variables:
- Environment variables (vars ususally set in terminal)
- Terraform variables (vars that will normally be set in tfvars file)

Terraform Cloud Variables can be marked as sensitive which will hide their values in TFC web page. 

### Loading Terraform Variables

#### var flag

We can use the `-var` flag to input variable or override a variable in the tfvars file at runtime (e.g. `terraform apply -var var_name="var_value"`)

#### var-file flag

To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either `.tfvars` or `.tfvars.json`) and then specify that file on the command line with `-var-file`

```
terraform apply -var-file="testing.tfvars"
```

#### terraform.tfvars

This is a default file from which Terraform will load variables in bulk

#### auto.tfvars

Terraform also automatically loads a number of variable definitions files if they are present:
- Files named exactly `terraform.tfvars` or `terraform.tfvars.json`.
- Any files with names ending in `.auto.tfvars` or `.auto.tfvars.json`.

#### order of terraform variable

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables
- The `terraform.tfvars` file, if present.
- The `terraform.tfvars.json` file, if present.
- Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
- Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

## Dealing with configuration drift

### What happens if we lose our state file?

If we lose our state file, we would most likely need to destroy all infrastructure deployed on cloud manually.

We can also use terraform import, but not all cloud resources can be imported that way so we will need to investigate what resources can and what can't be imported.

### Fix Missing Resources with Terraform Import

- We can use a Terraform import command, the old way, to import resources into state (e.g. S3 Bucket).

```
terraform import aws_s3_bucket.bucket bucket-name
```

- We can use Terraform import block, the new way, to import resource into state (e.g. S3 Bucket).

```
import {
  to = aws_s3_bucket.bucket
  id = "bucket-name"
}
```
More information on terraform import and S3 bucket import can be found on links bellow:

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[Importing AWS S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

### Fix Manual Configuration

If somehow our infrastructure gets modified by ClickOps when a `terraform plan` is runned it will try to fix our infrastructure and move it back to the desired state defined in Terraform code. It will try to fix our configuration drift.

### Fix using Terraform Refresh

Altough this command is deprecated in Terraform it can still be used.

```
terraform apply -refresh-only -auto-approve`
```

## Terraform Modules

### Terraform Module Structure

The recommended way is to place modules in a `modules` directory when locally developing modules.

```
PROJECT_ROOT
  ├── modules
      ├── module_name
          ├── README.md
          ├── main.tf
          ├── variables.tf
          ├── outputs.tf
```

### Modules Sources

Using the source we can import terraform modules from various places e.g.:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules)

### Passing Input Variables

We can pass input variables to terraform modules but the modules has to declare varaibles we are passing in its own varaibles.tf file.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  environment = var.environment
}
```

## ChatGPT for writing Terraform

LLMs such as ChatGPT may not be trained on the latest available informations, hence they can't really be fully realied on for writing Terraform code as they may not be aware of latest Terraform features.

Use them as help but do check the official Terraform documentation for most relevat informations.

## Working with files in Terraform

### Fileexists function

A built in Terraform function to check does file exists e.g.:

```tf
condition = fileexists(var.index_html_file_path)
```

[Fileexists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5 function

`filemd5` is a variant of `md5` that hashes the contents of a given file rather than a literal string.

```tf
etag = filemd5(var.index_html_file_path)
```

[FileMD5 Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)
### Path Variable

In terraform a special variable called `path` enables us to reference local paths:

- path.module
- path.root

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "website_index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
  etag = filemd5(var.index_html_file_path)
}
```

## Working with data in Terraform

### Terraform Locals

A local value assigns a name to an expression, so we can use the name multiple times within a module instead of repeating the expression.

```tf
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```

The expressions in local values are not limited to literal constants; they can also reference other values in the module in order to transform or combine them, including variables, resource attributes, or other local values:

```tf
locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}
```

[Terraform Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

A data source is accessed via a special kind of resource known as a *data resource*, declared using a `data block`:

```tf
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}

```

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

```

[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

### Woking with JSON

`jsonencode` can be used to create inline json policy in the Terraform HCL.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources

Lifecycle is a nested block that can appear within a resource block. The lifecycle block and its contents are meta-arguments, available for all resource blocks regardless of type.

The arguments available within a lifecycle block are: 
- create_before_destroy
- prevent_destroy
- ignore_changes
- replace_triggered_by.

```tf
resource "azurerm_resource_group" "example" {
  # ...

  lifecycle {
    create_before_destroy = true
  }
}
```

[Meta-Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data Resource

The terraform_data implements the standard resource lifecycle, but does not directly take any other actions. You can use the terraform_data resource without requiring or configuring a provider. It is always available through a built-in provider with the source address terraform.io/builtin/terraform.

The terraform_data resource is useful for storing values which need to follow a manage resource lifecycle, and for triggering provisioners when there is no other logical managed resource in which to place them.

```tf
variable "revision" {
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

# This resource has no convenient attribute which forces replacement,
# but can now be replaced by any change to the revision variable value.
resource "example_database" "test" {
  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}
```

[Terraform Data Resource](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Terraform Provisioners

You can use provisioners to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.

**NOTE: Provisioners are a Last Resort!!!**

Provisioners are not recommended by Hashicorp because better cnfiguration management tools exist like Ansible and others.

### file provisioner

The file provisioner copies files or directories from the machine running Terraform to the newly created resource. The file provisioner supports both ssh and winrm type

```tf
resource "aws_instance" "web" {
  # ...

  # Copies the myapp.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = "conf/myapp.conf"
    destination = "/etc/myapp.conf"
  }

  # Copies the string in content into /tmp/file.log
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/file.log"
  }

  # Copies the configs.d folder to /etc/configs.d
  provisioner "file" {
    source      = "conf/configs.d"
    destination = "/etc"
  }

  # Copies all files and folders in apps/app1 to D:/IIS/webapp1
  provisioner "file" {
    source      = "apps/app1/"
    destination = "D:/IIS/webapp1"
  }
}
```

### local-exec

The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource. See the remote-exec provisioner to run commands on the resource.

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}
```

### remote-exec

The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc. To invoke a local process, see the local-exec provisioner instead. The remote-exec provisioner requires a connection and supports both ssh and winrm.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

#### HereDoc

Terraform also supports a "heredoc" style of string literal inspired by Unix shell languages, which allows multi-line strings to be expressed more clearly.

```tf
<<EOT
hello
world
EOT
```

Example:

```tf
resource "terraform_data" "invalidate_cache" {
  triggers_replace = terraform_data.content_version.output

  provisioner "local-exec" {
    command = <<EOT
aws cloudfront create-invalidation \
--distribution-id ${aws_cloudfront_distribution.s3_distribution.id} \
--paths '/*'
    EOT
  }
}
```

## Terraform for_each

for_each is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.

The for_each meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

Map:

```tf
resource "azurerm_resource_group" "rg" {
  for_each = {
    a_group = "eastus"
    another_group = "westus2"
  }
  name     = each.key
  location = each.value
}
```

Set of strings:

```tf
resource "aws_iam_user" "the-accounts" {
  for_each = toset( ["Todd", "James", "Alice", "Dottie"] )
  name     = each.key
}
```

In blocks where for_each is set, an additional each object is available in expressions, so you can modify the configuration of each instance. This object has two attributes:

- each.key — The map key (or set member) corresponding to this instance.
- each.value — The map value corresponding to this instance. (If a set was provided, this is the same as each.key.)

[Terraform for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

## Terraform fileset

Fileset enumerates a set of regular file names given a path and pattern. The path is automatically removed from the resulting set of file names and any result still containing path separators always returns forward slash (/) as the path separator for cross-system compatibility.

Example:

```tf
> fileset(path.module, "files/*.txt")
[
  "files/hello.txt",
  "files/world.txt",
]

> fileset(path.module, "files/{hello,world}.txt")
[
  "files/hello.txt",
  "files/world.txt",
]

> fileset("${path.module}/files", "*")
[
  "hello.txt",
  "world.txt",
]

> fileset("${path.module}/files", "**")
[
  "hello.txt",
  "world.txt",
  "subdirectory/anotherfile.txt",
]
```

A common use of fileset is to create one resource instance per matched file, using the for_each meta-argument:

```tf
resource "example_thing" "example" {
  for_each = fileset(path.module, "files/*")

  # other configuration using each.value
}
```