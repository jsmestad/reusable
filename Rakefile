#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'cucumber/rake/task'

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end

Bundler::GemHelper.install_tasks
