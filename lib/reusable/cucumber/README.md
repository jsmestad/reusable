# Reusable Cucumber

## Step Definitions

### Authentication Steps

require 'reusable/cucumber/step\_definitions/authentication\_steps.rb'

Provides an opinionated set of cucumber steps to use while testing
authentication of your Rails application. Please view YARD docs for
step expectations.

### Base Steps

require 'reusable/cucumber/step\_definitions/base\_steps.rb'

Provides a base set of steps that should work on any Rails application.
This module includes steps for accessing the Ruby debugger, web step
aliases and accessing flash messages.
