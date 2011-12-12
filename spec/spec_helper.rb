# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Should matchers
require 'shoulda/matchers'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path('../dummy/db/migrate/', __FILE__)

RSpec.configure do |config|
  config.include RSpec::Matchers

  config.use_transactional_fixtures = true
end
