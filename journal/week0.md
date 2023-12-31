# Terraform Beginner Bootcamp 2023 - Week 0

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Terraform CLI](#terraform-cli)
  * [Bash script](#bash-script)
    + [Linux distribution](#linux-distribution)
    + [SheBang consideration](#shebang-consideration)
    + [CHMOD consideration](#chmod-consideration)
  * [Gitpod configuration](#gitpod-configuration)
  * [Working with Env Vars](#working-with-env-vars)
    + [env command](#env-command)
    + [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    + [Printing Vars](#printing-vars)
    + [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [AWS CLI Installation](#aws-cli-installation)
  * [VSCode extensions](#vscode-extensions)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
  * [Terraform Init](#terraform-init)
  * [Terraform Plan](#terraform-plan)
  * [Terraform Apply](#terraform-apply)
  * [Terraform Destroy](#terraform-destroy)
  * [Terraform Lock Files](#terraform-lock-files)
  * [Terraform State Files](#terraform-state-files)
- [AWS S3 bucket](#aws-s3-bucket)
- [Terraform Cloud Login](#terraform-cloud-login)
  * [Automated terraform cloud login](#automated-terraform-cloud-login)
  * [TF as alias for Terraform](#tf-as-alias-for-terraform)

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.

More information on Semantic Versioning can be found on [semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Terraform CLI

Installation of Terraform CLI has changed due to gpg keyring changes on Ubuntu based Linux systems. 
In order to fix the issue a change in default terraform cli installation provided with git repo template was needed to reflect the latest instructions from Hashicorp Terraform Installation guide.

Terraform official installation guide can be found at [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Bash script

In order to have a more tidy [.gitpod.yml](.gitpod.yml) file terraform cli installation was moved to dedicated bash script.
A dedicated shell script named [install_terraform_cli.sh](./bin/install_terraform_cli.sh) is created as an executable file and is wrriten for Ubuntu Linux as gitpod uses Ubuntu 22.04 as a base OS.

#### Linux distribution  

To find out what Linux distribution we are running we need to execute `cat /etc/os-release` command in terminal an the command will output what distro we are running.

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

More information on how to find what Linux distro we are running can be found on a link. [What is my Linux distro?](https://www.cyberciti.biz/faq/find-linux-distribution-name-version-number/)

#### SheBang consideration

On linux systems we need to use SheBang (pronounced "Sha-Bang") at the start of a script so that the interpreter knows what program it needs to use to execute the script.

Most standard shebang example is:

```sh
#!/bin/bash
```

For better portability of scripts we can use an alternate shebang that actually targets bash program for specific user (a user that is actually executing the script):

```sh
#!/usr/bin/env bash
```

More information on SheBang can be found on link. [What is shebang?](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### CHMOD consideration

In order to actually run (execute) the script we needed to change the permissions on a script to make it executable.
On a user level this is done buy running the command bellow.

```sh
chmod u+x ./bin/install_terraform_cli.sh
```

Alternatively we can achive the same thing by running the command bellow.

```sh
chmod 744 ./bin/install_terraform_cli.sh
```

More information on Linux permissions can be found on a link. [What is chmod?](https://en.wikipedia.org/wiki/Chmod)


### Gitpod configuration

In order to use our custom [install_terraform_cli.sh](./bin/install_terraform_cli.sh) script for terraform cli installation we needed to update [.gitpod.yml](.gitpod.yml) file.
To have this script run every time a gitpod workspace is created or started we needed to change **init** to **before** inside a .gitpod.yml file where we actually sourced the install_terraform_cli.sh script.

```yaml
tasks:
  - name: terraform
    before: |
      source ./bin/install_terraform_cli.sh
```
More information on how to configure gitpod workspaces can be found on a link. [Gitpod documentation](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Working with Env Vars

#### env command

We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO="world"`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open new bash terminals in VSCode it will not be aware of env vars that you have set in another windows.

If you want env vars to persist across all future terminals that are open you need to set env vars in your bash profile.

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing thenm in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminal opened in thoes workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [install_aws_cli.sh](./bin/install_aws_cli.sh)

More information on how to install and use AWS CLI can be found on link bellow: 

[AWS CLI getting started](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We need to create a user on AWS and generate CLI access credentials for that user. 
After a user on AWS is created we need to configure our gitpod environment to use those user CLI access credentials. 

This is done by setting those credentials as gitpod secrets (global env vars).


```sh
gp env AWS_ACCESS_KEY_ID='aws_user_access_key_id'
gp env AWS_SECRET_ACCESS_KEY='aws_user_secret_access_key'
gp env AWS_DEFAULT_REGION='aws_user_default_aws_region'
```

We can check if our AWS credentials are configured correctly by running the  following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is succesful we should see a json payload return that looks like this:

```json
{
    "UserId": "USER_ID",
    "Account": "ACCOUND_ID",
    "Arn": "arn:aws:iam::ACCOUND_ID:user/username"
}

```

### VSCode extensions

I needed a better git graph extension hence I have install **mhutchie.git-graph** by adding it to vscode extensions block in [.gitpod.yml](.gitpod.yml) file.

```yml
vscode:
  extensions:
    - amazonwebservices.aws-toolkit-vscode
    - hashicorp.terraform
    - mhutchie.git-graph
```

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which are located at [registry.terraform.io](https://registry.terraform.io/)

- Provider is an interface to APIs that will allow you to create resource
- Modules are a way to generalize a chuck of repeatable code in order to reuse the code it for multiple projects.

### Terraform Console

To outpull all available terraform commands run the command `terraform` in terminal

### Terraform Init

To start any terraform project we need to run `terraform init` in the terminal. This allows terraform to download all necessary providers and modules and initialize the project in the directory

### Terraform Plan

When `terraform plan` is executed as a command in terminal terraform will print out what changes will occur on our infrastructure.

### Terraform Apply

When we run `terraform apply` in terminal terraform will apply the previous plan if we already have it and will actually make the changes to our infrastructre. 
Terraform apply have to be approved by the user and that can be done either by manual user intervention or we can tell terraform to auto approve by running apply with -auto-approve option eg. `terraform apply -auto-approve`

### Terraform Destroy

`terraform destroy` command is used to destroy all resources on our infrastructure based on our code and tfstate

### Terraform Lock Files

`.terraform.lock.hcl` is a file where terraform stores all necessary information about providers and modules used by the project. This file should be commited to a version control system.

### Terraform State Files

`.terraform.tfstate` is a file where terraform saves the actual state of our infrastructure. **This file should never be edited manually nor commited to a version control system. This file can contain sensitive data**

## AWS S3 bucket

S3 buckets have a relativly strict naming convention and we need to be aware of it when creating S3 buckets via Terraform.

For more information visit [S3 naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)

## Terraform Cloud Login

When using Gitpod there is an issue with Gitpod login due to VSCode running in browser and `terrafom login` command wants us to due the login via terminal, which well does not really render properlly in Gitpod.

The workaround is:

- Generate API token in Terraform Cloud
```
https://app.terraform.io/app/settings/tokens
```

- Manually create local credentials.tfrc.json file 
```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```

- Open a file and add json block to it
```sh
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR_TERRAFORM_CLOUD_TOKEN"
    }
  }
}
```

- Run `terraform init`

### Automated terraform cloud login

As manually login to terraform cloud on each gitpod startup was a hustle I have made a bash script that automates the proccess.

Script checks if env var TERRAFORM_CLOUD_TOKEN is set in gitpod and if it is script will create `/home/gitpod/.terraform.d/credentials.tfrc.json` file and load our TERRAFORM_CLOUD_TOKEN to credentials.tfrc.json file.

Bash script used to achive this [generate_tfrc_credentials.sh](./bin/generate_tfrc_credentials.sh)

I have also made the script executable and sourced it in [.gitpod.yml](.gitpod.yml) and I added TERRAFORM_CLOUD_TOKEN as global gitpod env var, A.k.a gitpod secret.

### TF as alias for Terraform

To be quicker on the command line I have set `tf` as an alias for `terraform` command, and I have also enabled terraform autocompletion in bash for both `tf` and `terraform` command.

This is automatically configured on gitpod startup with a scitp [set_tf_alias.sh](./bin/set_tf_alias.sh)