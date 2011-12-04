module Reusable::Cucumber
  module StepDefinitions
    module BaseSteps
      When /^(?:|I )click "([^"]*)"$/ do |link|
        When %{I follow "#{link}"}
      end
    end
  end
end
