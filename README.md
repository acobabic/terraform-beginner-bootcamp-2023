# Terraform Beginner Bootcamp 2023

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

```bash
#!/bin/bash
```

For better portability of scripts we can use an alternate shebang that actually targets bash program for specific user (a user that is actually executing the script):

```bash
#!/usr/bin/env bash
```

More information on SheBang can be found on link. [What is shebang?](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### CHMOD consideration

In order to actually run (execute) the script we needed to change the permissions on a script to make it executable.
On a user level this is done buy running the command bellow.

```bash
chmod u+x ./bin/install_terraform_cli.sh
```

Alternatively we can achive the same thing by running the command bellow.

```bash
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