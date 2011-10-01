begin
  require 'rspec'
rescue LoadError
  require 'rubygems'
  require 'rspec'
end

module Reusable
  module RSpec
    module Support; end
  end
end
