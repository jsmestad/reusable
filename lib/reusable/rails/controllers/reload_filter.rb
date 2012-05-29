# ReloadFilter is a development enhancement that adds support for
# reloading files located under the Rails.root/lib/**/* directory
# on each request. Without this, Rails will not reload these files
# on every request meaning that you have to restart the server with
# every file modification.
#
module Reusable::Rails
  module Controllers
    module ReloadFilter
      extend ActiveSupport::Concern

      included do
        before_filter :_reload_libs, :if => :_reload_libs?
      end

      # Iterate over every directory specified in RELOAD_LIBS and
      # re-require the file.
      def _reload_libs
        RELOAD_LIBS.each do |lib|
          require_dependency lib
        end
      end

      # Conditional check to ensure that we should reload libraries.
      # If RELOAD_LIBS is not defined, we skip this. It is a good
      # idea to also ensure we are in development mode when defining
      # it.
      #
      # @returns [Boolean]
      # (see #_reload_libs)
      def _reload_libs?
        defined? RELOAD_LIBS
      end
    end
  end
end
