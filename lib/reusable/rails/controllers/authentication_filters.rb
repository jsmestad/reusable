# The AuthenticationFilters module adds utility and filter methods to
# the Rails controller.
#
module Reusable::Rails
  module Controllers
    module AuthenticationFilters
      extend ActiveSupport::Concern

      included do
        # We start with a walled garden. Use skip_before_filter to circumvent.
        before_filter :ensure_user
      end

      # Filter method for ensuring a user session exists for the given request.
      #
      # @returns [Boolean]
      def ensure_user
        return true if current_user?
        if block_given?
          yield
        else
          redirect_to root_path
          return false
        end
      end

      # Filter method for ensuring a user session does not exist for the given request.
      #
      # @returns [Boolean]
      def ensure_no_user
        return true unless current_user?
        if block_given?
          yield
        else
          redirect_to root_path
          return false
        end
      end
    end
  end
end
