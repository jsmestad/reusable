# Adds controller support for serving static views, but still allowing
# the use of layouts and HAML/ERB/etc.
#
# Assuming your controller is called PagesController,
# you also need to add the following to your config/routes.rb file:
#   get '/:page_name',
#     to: 'pages#show',
#     constraints: { page_name: /landing/i }
#
#   root to: 'pages#show', defaults: { page_name: 'landing' }
#
module Reusable::Rails
  module Controllers
    module StaticController
      extend ActiveSupport::Concern

      included do
        # If the template is missing, you can try catching and sending a
        # 404 with this line.
        #
        # rescue_from ActionView::MissingTemplate, :with => :invalid_page
      end

      module InstanceMethods
        def show
          render :template => current_page
        end

      protected

        def invalid_page
          render :nothing => true, :status => 404
        end

        def current_page
          "pages/#{params[:page_name].to_s.downcase}"
        end
      end
    end
  end
end
