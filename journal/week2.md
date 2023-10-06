# Terraform Beginner Bootcamp 2023 - Week 2

- [Working with Ruby](#working-with-ruby)
  * [Bundler](#bundler)
    + [Install Gems](#install-gems)
    + [Executing ruby scripts in the context of bundler](#executing-ruby-scripts-in-the-context-of-bundler)
  * [Sinatra](#sinatra)
- [Terratowns Mock Server](#terratowns-mock-server)
  * [Running the web server](#running-the-web-server)
- [Terraform Custom Provider (terratowns)](#terraform-custom-provider--terratowns-)
  * [CRUD](#crud)
- [Git Tip](#git-tip)


## Working with Ruby

### Bundler

Bundler is a package manager for Ruby. It is the primary way to install ruby packages (know as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then to install all the gems globally on the system we need to run `bundle install` command.

A Gemfile.lock will be created to lock down the gem version used in the project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell the future ruby scripts to use the gem we installed. This is the way we set context.

### Sinatra 

Sinatra is a micro web-framework for ruby to build web-apps. It is great for mock or development servers for very simple project.

You can create a web server in a single file.

[Sinatra](https://sinatrarb.com/)


## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## Terraform Custom Provider (terratowns)

Copied [main.go](/terraform-provider-terratowns/main.go) from [Andrew Brown Git Repo](https://github.com/omenking/terraform-beginner-bootcamp-2023) as I'm currently not familiar enough with [goLang](https://go.dev/).

Created a [build_provider.sh](/bin/build_provider.sh) script that actually build the tarratowns custom provider binary and copy it to the terraform expected directory on system (gitpod).

Created [terraformrc](/terraformrc) file that defines paths where terraform should look for local providers (our custom terratown provider)

Enabled DEBUG in terraform output with env var `TF_LOG: DEBUG` by defining it in [.gitpod.yml](/.gitpod.yml) file.

More information on Terraform Providers and how to make them can be found on links bellow:

- [Terraform Providers](https://developer.hashicorp.com/terraform/registry/providers/docs)
- [Terraform Providers 2](https://developer.hashicorp.com/terraform/language/providers)

### CRUD

Terraform providers utilize CRUD (create read update delete)

[About CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)

## Git Tip

In case where work needs to be done on a specific feature branch that is behind main and to avoid merge conflicts we need to pull the latest from main, merge main into our feature branch before we commit and push changes from feature branch.

I ususally do this by executing following commands:

```sh
git checkout feat_branch
git fetch
git checkout main
git pull
git checkout feat_branch
git merge main
```

