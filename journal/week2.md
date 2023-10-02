# Terraform Beginner Bootcamp 2023 - Week 2

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