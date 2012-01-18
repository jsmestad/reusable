begin
  require 'active_support/concern'
rescue LoadError
  require File.expand_path('../active_support/concern.rb', __FILE__)
end

module Reusable
  autoload :Cucumber, 'reusable/cucumber'
  autoload :Mongoid, 'reusable/mongoid'
  autoload :Rails, 'reusable/rails'
  autoload :RSpec, 'reusable/rspec'
end

require 'reusable/version'
