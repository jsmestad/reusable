$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reusable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jsmestad_reusable"
  s.version     = Reusable::VERSION
  s.authors     = ["Justin Smestad"]
  s.email       = ["justin.smestad@gmail.com"]
  s.homepage    = "https://github.com/jsmestad/reusable"
  s.summary     = "TODO: Summary of Reusable."
  s.description = "TODO: Description of Reusable."

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["{features,spec}/**/*"]

  s.add_dependency "bcrypt-ruby"
  s.add_dependency "rails", "~> 3.1.3"

  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
  s.add_development_dependency "fabrication"
  s.add_development_dependency "ffaker"
end
