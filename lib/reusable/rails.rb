module Reusable
  module Rails
    module Controllers
      autoload :AuthenticationHelpers, 'reusable/rails/controllers/authentication_helpers.rb'
      autoload :MissingRecordHandler, 'reusable/rails/controllers/missing_record_handler.rb'
      autoload :PresentationMethods, 'reusable/rails/controllers/presentation_methods.rb'
      autoload :ReloadFilter, 'reusable/rails/controllers/reload_filter.rb'
    end

    module Models
      autoload :Paranoid, 'reusable/rails/models/paranoid.rb'
    end
  end
end
