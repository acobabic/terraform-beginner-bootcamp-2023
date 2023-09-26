# Terraform Beginner Bootcamp 2023 - Week 1

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

