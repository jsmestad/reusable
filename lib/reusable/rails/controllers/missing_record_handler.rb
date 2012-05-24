# The MissingRecordHandler module adds controller support for
# cleanly raising, and rescuing from, ActiveRecord::RecordNotFound
# errors.
#
# Ensure active_record/errors are loaded
#
module Reusable::Rails
  module Controllers
    module MissingRecordHandler
      extend ActiveSupport::Concern

      included do
        # Catch any RecordNotFound errors and route them appropriately
        # to the 404 handler.
        #
        # (see #record_not_found)
        # (see #render_404)
        rescue_from ActiveRecord::RecordNotFound, :with => :render_404
      end

      module InstanceMethods
        # Helper method to ensure the proper error is always raised.
        # This should be called when throwing a not found error instead
        # of invoking the error directly.
        #
        # @returns [ActiveRecord::RecordNotFound]
        # (see #render_404)
        def record_not_found
          raise ActiveRecord::RecordNotFound
        end

      protected

        # Handles any ActiveRecord::RecordNotFound errors that may be thrown during
        # the request cycle. It will push an entry into the log file and render the
        # appropriate response based on the mime type of the request.
        #
        # @note ensure that if you ever invoke this method you return immediately to
        #   avoid a possible double render error.
        def render_404(exception=nil)
          logger.info "Rendering 404 with exception: #{exception.message}" if exception.present?

          respond_to do |format|
            format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found, :layout => false }
            format.json { render :text => 'Not Found', :status => :not_found }
            format.xml  { head :not_found }
            format.any  { head :not_found }
          end
        end
      end
    end
  end
end
