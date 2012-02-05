$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reusable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reusable"
  s.version     = Reusable::VERSION
  s.authors     = ["Justin Smestad"]
  s.email       = ["justin.smestad@gmail.com"]
  s.homepage    = "https://github.com/jsmestad/reusable"
  s.summary     = "Reusable mixins for Rails, RSpec, and Cucumber."
  s.description = "Reusable mixins for Rails, RSpec, and Cucumber."

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["{features,spec}/**/*"]

  s.add_dependency "bcrypt-ruby"
  s.add_dependency "rails", "~> 3.1.1", "<= 4"

  s.add_development_dependency "mongoid"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "fabrication"
  s.add_development_dependency "ffaker"
end
