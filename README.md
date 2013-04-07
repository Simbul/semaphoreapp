# Semaphoreapp

A Ruby client for the Semaphore API.

## Installation

Add this line to your application's Gemfile:

    gem 'semaphoreapp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install semaphoreapp

## Configuration

To use the [Semaphore API](http://docs.semaphoreapp.com/api), you need an `auth_token`. You can find your token through the Semaphore web interface.

To configure the gem with your token, add a line such as:

```ruby
Semaphoreapp.auth_token = 'Yds3w6o26FLfJTnVK2y9'
```

The token will be cached, so you will only need to set it once.

## Usage

### Projects

To get all the projects associated with your auth token:

```ruby
projects = Semaphoreapp::Project.all
```

To get a specific project (based on its name):

```ruby
project = Semaphoreapp::Project.find_by_name('testapp-sphinx')
```

Once you have a project, you can get all its branches:

```ruby
project.get_branches
```

Note that, due to the way the API works, the following call will return all the branch *statuses* for a given project:

```ruby
project.branches
```

### Branches

Note that all the class methods for `Branch` require the hash id of the project to be passed in as a parameter (`3f1004b8343faabda63d441734526c854380ab89` in the examples below).

To get a specific branch (based on its name):

```ruby
branch = Semaphoreapp::Branch.find_by_name('3f1004b8343faabda63d441734526c854380ab89', 'master')
```

Once you have a branch, you can get its current status:

```ruby
branch.get_status
```

or its build history:

```ruby
branch.get_builds
```

### Builds

Note that the following examples assume you already have a `build` object, which you can obtain by doing something like:

```ruby
build = Semaphoreapp::Branch.find_by_name('3f1004b8343faabda63d441734526c854380ab89', 'master').get_builds.first
```

To get the build information:

```ruby
build.get_information
```

This will return a `BuildInformation` instance which in turn contains a list of `Commit` instances.

To get the build log:

```ruby
build.get_log
```

This will return a `BuildLog` instance which in turn contains a list of `Thread` instances. Each of the threads contains a list of `Command` instances.

## Object model

The gem uses classes to represent objects returned by API calls. The classes are:

* `Project`: a project Semaphore is running CI for. It may have many `BranchStatus` objects.
* `BranchStatus`: the status of a branch in a project. It may have a `Commit` object.
* `Branch`: a branch in a project.
* `Build`: a CI build. It may have a `Commit` object.
* `Commit`: a Git commit.
* `BuildInformation`: the information related to a build. It may have many `Commit` objects.
* `BuildLog`: the log for a build. It may have many `Thread` objects.
* `Thread`: a build thread. It may have many `Command` objects.
* `Command`: a command in a build thread.

## Tests

To run all the specs for this project:

```bash
$ rake
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
