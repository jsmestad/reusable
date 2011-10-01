begin
  require 'cucumber'
rescue LoadError
  require 'rubygems'
  require 'cucumber'
end

module Reusable
  module Cucumber
    module StepDefinitions
      autoload :AuthenticationSteps, 'cucumber/step_definitions/authentication_steps.rb'
    end
  end
end
