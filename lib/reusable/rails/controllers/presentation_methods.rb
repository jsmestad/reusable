# The PresentationMethods module adds presentation helpers to a given
# controller and view. The goal is to DRY up any remaining view logic
# with a minimal set of attribute methods.
#
module Reusable::Rails
  module Controllers
    module PresentationMethods
      extend ActiveSupport::Concern

      included do
        # Make these attribute readers available in views
        #
        # (see #body_class)
        # (see #page_title)
        helper_method :body_class, :page_title
      end

      # Override the CSS class that this view will attach
      # to the <body> element of the associated view.
      #
      # @params [String] name of the CSS selector
      # (see #body_class)
      def body_class=(val)
        @body_class = val
      end

      # Return the CSS selector class that should be appended
      # to the <body> element of the associated view.
      #
      # The default behavior, if unset, is to use the controller
      # name.
      #
      # @returns [String] the name of the CSS selector
      # (see #body_class=)
      def body_class
        @body_class || controller_name
      end

      # Return the page title for the requested action. By default, the
      # CSS selector returned by the body_class method is titleized and
      # used.
      #
      # @returns [String] the page title for the given action
      # (see #body_class)
      def page_title
        @page_title ||= body_class.titleize
      end

      # Override the default page title with the specified value.
      #
      # @params [String] the transformed page title value.
      # (see #page_title)
      def page_title=(val)
        @page_title = val
      end
    end
  end
end
