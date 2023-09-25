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
